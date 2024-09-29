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
  Timer? _monitoringTimer;
  StreamSubscription? _portSubscription;
  List<int> buffer = [];
  final List<SensorModel> sensors = [];
  final LocationService locationService = LocationService();

  String? currentSensorId;

  List<MeasurementModel> sensor1TempMeasurements = [];
  List<MeasurementModel> sensor2TempMeasurements = [];

  SerialPortProvider() {
    listAvailablePorts();
  }

  InputState get state => _state;

  void startMonitoring() {
    _monitoringTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkConnection();
    });
  }

  void _checkConnection() {
    if (port != null && port!.isOpen) {
      _updateState(InputCapturingDataState());
      _startReading();
    } else {
      if (_state is! InputCapturingDataState) {
        _updateState(InputConnectionClosedState());
        _stopReading();
      }
    }
  }

  void _updateState(InputState newState) {
    _state = newState;
    notifyListeners();

    switch (newState.runtimeType) {
      case const (InputWaitingConnectionState):
        GlobalSnackBar.error('Nenhuma porta encontrada');
        break;
      case const (InputEstablishingConnectionState):
        GlobalSnackBar.success('Porta encontrada e conectada');
        break;
      case const (InputCapturingDataState):
        GlobalSnackBar.info('Captando dados...');
        break;
      case const (InputConnectionClosedState):
        GlobalSnackBar.info('Porta desconectada');
        break;
      case const (InputErrorState):
        GlobalSnackBar.error('Erro na porta serial');
        break;
    }
  }

  void _startReading() {
    try {
      if (port == null || !port!.openReadWrite()) {
        throw Exception('Erro ao abrir a porta');
      }

      final reader = SerialPortReader(port!);

      _portSubscription = reader.stream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((line) async {
        // Processa cada linha de dados
        try {
          Position? position = await locationService.getCurrentLocation();
          List<MeasurementModel> measurements =
              await processSerialData(line, position);

          // Processa as medições para o sensor atual
          _processMeasurements(measurements);

          notifyListeners();
        } catch (e) {
          GlobalSnackBar.error('Erro ao processar dados: ${e.toString()}');
        }
      });
    } catch (e) {
      GlobalSnackBar.error('Erro ao iniciar a leitura: ${e.toString()}');
    }
  }

  void _processMeasurements(List<MeasurementModel> measurements) {
    currentSensorId = measurements.first.sensorId.toString();
    sensor1TempMeasurements.add(measurements[0]);
    sensor2TempMeasurements.add(measurements[1]);

    GlobalSnackBar.info(
        'Medições temporárias do sensor $currentSensorId atualizadas.');
  }

  void finalizeReading() {
    if (currentSensorId == null) return;

    SensorModel? sensor =
        sensors.firstWhere((sensor) => sensor.id == currentSensorId);

    if (sensor1TempMeasurements.isNotEmpty &&
        sensor2TempMeasurements.isNotEmpty) {
      MeasurementHistory newHistory = MeasurementHistory(
        sensorId: currentSensorId!,
        sensor1Measurements: List.from(sensor1TempMeasurements),
        sensor2Measurements: List.from(sensor2TempMeasurements),
      );

      sensor.history.add(newHistory);

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

  void _stopReading() {
    _portSubscription?.cancel();
    port?.close();

    finalizeReading();
    _updateState(InputConnectionClosedState());
  }

  void stopMonitoring() {
    _monitoringTimer?.cancel();
    _portSubscription?.cancel();
    port?.close();
    _setNoConnection();
  }

  void listAvailablePorts() {
    availablePorts = SerialPort.availablePorts;
    notifyListeners();
  }

  void selectPort(String portName) {
    selectedPort = portName;
    port = SerialPort(portName);

    if (!port!.openReadWrite()) {
      selectedPort = null;
      GlobalSnackBar.error('Erro ao abrir a porta $portName');
    } else {
      GlobalSnackBar.success('Porta $portName conectada com sucesso');

      _updateState(InputCapturingDataState());

      _startReading();

      notifyListeners();
    }
  }

  void _setNoConnection() {
    selectedPort = null;
    _updateState(InputWaitingConnectionState());
    notifyListeners();
  }
}
