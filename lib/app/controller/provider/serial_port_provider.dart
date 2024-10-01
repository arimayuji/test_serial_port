import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_for_serial_port/app/models/measurement_history_model.dart';
import 'package:test_for_serial_port/app/models/measurement_model.dart';
import 'package:test_for_serial_port/app/models/sensor_model.dart';
import 'package:test_for_serial_port/app/services/location_service.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/global_snackbar.dart';
import 'package:test_for_serial_port/app/views/home/state/measurement_state.dart';
import '../../shared/helpers/functions/parser_sensor_data.dart';

class SerialPortProvider extends ChangeNotifier {
  List<String> availablePorts = [];
  String? selectedPort;
  SerialPort? port;
  InputState _state = InputWaitingConnectionState();
  StreamSubscription? _portSubscription;
  List<String> buffer = [];
  Timer? _monitorPortStatusTimer;

  final List<SensorModel> sensors = [];
  final LocationService locationService = LocationService();

  String? currentSensorId;

  List<MeasurementModel> sensor1TempMeasurements = [];
  List<MeasurementModel> sensor2TempMeasurements = [];

  SerialPortProvider() {
    _startListAvailablePorts();
  }

  InputState get state => _state;

  void _updateState(InputState newState) {
    _state = newState;
    notifyListeners();

    switch (newState.runtimeType) {
      case const (InputWaitingConnectionState):
        GlobalSnackBar.error(newState.inputMessage);
        break;
      case const (InputEstablishingConnectionState):
        GlobalSnackBar.success(newState.inputMessage);
        break;
      case const (InputCapturingDataState):
        GlobalSnackBar.info(newState.inputMessage);
        break;
      case const (InputConnectionClosedState):
        GlobalSnackBar.info(newState.inputMessage);
        break;
      case const (InputErrorState):
        GlobalSnackBar.error(newState.inputMessage);
        break;
    }
  }

  void _startReading() {
    buffer.clear();
    try {
      if (selectedPort == null) {
        GlobalSnackBar.error('Porta serial desconectada, encerrando leitura.');
        return;
      }

      if (_state is! InputConnectionClosedState) {
        final reader = SerialPortReader(port!);

        _portSubscription = reader.stream
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .listen((line) {
          buffer.add(line);
        }, onDone: () {
          _handlePortDisconnection();
        }, onError: (error) {
          _handlePortDisconnection();
          GlobalSnackBar.error('Erro durante leitura: $error');
        });
      }
    } catch (e) {
      GlobalSnackBar.error('Erro ao iniciar a leitura: ${e.toString()}');
    }
  }

  void _handlePortDisconnection() async {
    _monitorPortStatusTimer?.cancel();
    _portSubscription?.cancel();
    port?.close();

    selectedPort = null;
    notifyListeners();

    if (buffer.isNotEmpty) {
      await _processBufferedLines();
      finalizeReading();
    }
  }

  Future<void> _processBufferedLines() async {
    try {
      Position? position = await locationService.getCurrentLocation();
      for (String line in buffer) {
        List<MeasurementModel> measurements = await processSerialData(
          line,
          position,
        );
        _processMeasurements(measurements);
      }
      _updateState(InputCapturingDataState());
      notifyListeners();
    } catch (e) {
      GlobalSnackBar.error('Erro ao processar dados: ${e.toString()}');
    } finally {
      buffer.clear();
    }
  }

  void _processMeasurements(List<MeasurementModel> measurements) {
    currentSensorId = measurements.first.sensorId.toString();
    sensor1TempMeasurements.add(measurements[0]);
    sensor2TempMeasurements.add(measurements[1]);
  }

  void finalizeReading() {
    if (currentSensorId == null) return;

    SensorModel? sensor = sensors.firstWhere(
      (sensor) => sensor.id == currentSensorId,
      orElse: () => SensorModel(id: currentSensorId!, history: []),
    );

    if (sensor1TempMeasurements.isNotEmpty &&
        sensor2TempMeasurements.isNotEmpty) {
      MeasurementHistory newHistory = MeasurementHistory(
        sensorId: currentSensorId!,
        sensor1Measurements: List.from(sensor1TempMeasurements),
        sensor2Measurements: List.from(sensor2TempMeasurements),
      );

      sensor.history.add(newHistory);

      sensors.add(sensor);

      sensor1TempMeasurements.clear();
      sensor2TempMeasurements.clear();

      GlobalSnackBar.success(
          'Histórico do sensor $currentSensorId criado e adicionado.');
      notifyListeners();
    } else {
      GlobalSnackBar.error(
          'Erro ao criar o histórico: Dados insuficientes ou sensor não encontrado.');
    }
  }

  void stopReading() {
    _portSubscription?.cancel();
    port?.close();

    selectedPort = null;
    notifyListeners();

    _processBufferedLines().then((_) {
      finalizeReading();
    });
  }

  void _startListAvailablePorts() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      availablePorts = SerialPort.availablePorts;
      notifyListeners();
    });
  }

  void selectPort(String portName) {
    selectedPort = portName;
    port = SerialPort(portName);

    port!.config.baudRate = 115200;
    port!.config.stopBits = 1;
    port!.config.bits = 8;
    port!.config.parity = SerialPortParity.none;

    if (_state is InputConnectionClosedState) {
      selectedPort = null;
      GlobalSnackBar.info(_state.inputMessage);
    } else {
      GlobalSnackBar.success('Porta $portName conectada com sucesso');

      _updateState(InputEstablishingConnectionState());

      _startReading();

      notifyListeners();
    }
  }
}
