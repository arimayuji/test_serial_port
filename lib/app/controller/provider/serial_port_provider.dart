import 'dart:async';
import 'dart:typed_data';

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
  final SerialPort port;
  InputState _state = InputWaitingConnectionState();
  Timer? _monitoringTimer;
  StreamSubscription? _portSubscription;
  List<int> buffer = [];
  final List<SensorModel> sensors = []; // Lista de sensores
  final LocationService locationService = LocationService();

  String? currentSensorId;

  List<MeasurementModel> sensor1TempMeasurements = [];
  List<MeasurementModel> sensor2TempMeasurements = [];

  SerialPortProvider(this.port);

  InputState get state => _state;

  // Inicia o monitoramento da porta serial quando a aplicação é aberta
  void startMonitoring() {
    _monitoringTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkConnection();
    });
  }

  // Verifica se a porta serial está conectada
  void _checkConnection() {
    if (port.isOpen) {
        _updateState(InputCapturingDataState());
        _startReading();
    } else {
      if (_state is! InputCapturingDataState) {
        _updateState(InputConnectionClosedState());
        _stopReading();
      }
    }
  }

  // Atualiza o estado da conexão e exibe um SnackBar
  void _updateState(InputState newState) {
    _state = newState;
    notifyListeners();

    if (newState is InputWaitingConnectionState) {
      GlobalSnackBar.error('Nenhuma porta encontrada');
    } else if (newState is InputEstablishingConnectionState) {
      GlobalSnackBar.success('Porta encontrada e conectada');
    } else if (newState is InputCapturingDataState) {
      GlobalSnackBar.info('Captando dados...');
    } else if (newState is InputConnectionClosedState) {
      GlobalSnackBar.info('Porta desconectada');
    } else if (newState is InputErrorState) {
      GlobalSnackBar.error('Erro na porta serial');
    }
  }

  // Inicia a leitura dos dados da porta serial
  void _startReading() {
    if (!port.openReadWrite()) {
      GlobalSnackBar.error('Erro ao abrir a porta');
    }

    final reader = SerialPortReader(port);
    _portSubscription = reader.stream.listen((data) async {
      buffer.addAll(data);
      if (buffer.length >= 6 && buffer[5] == 13) {
        Position? position = await locationService.getCurrentLocation();

        List<MeasurementModel> measurements =
            await processSerialData(Uint8List.fromList(buffer), position);

        currentSensorId = measurements.first.sensorId.toString();

        bool isSensorExist =
            sensors.any((sensor) => sensor.id == currentSensorId);

        if (isSensorExist) {
          sensor1TempMeasurements.add(measurements[0]);
          sensor2TempMeasurements.add(measurements[1]);

          GlobalSnackBar.info(
              'Medições temporárias do sensor $currentSensorId atualizadas.');
        } else {
          GlobalSnackBar.error(
              'Sensor $currentSensorId não encontrado na lista.');
        }

        buffer.clear();
        notifyListeners();
      }
    });
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

  // Para a leitura quando a conexão é perdida e atualiza o histórico do sensor atual
  void _stopReading() {
    _portSubscription?.cancel();
    port.close();

    finalizeReading();

    _updateState(InputConnectionClosedState());
  }

  // Para o monitoramento ao encerrar a aplicação
  void stopMonitoring() {
    _monitoringTimer?.cancel();
    _portSubscription?.cancel();
    if (port.isOpen) {
      port.close();
    }
  }
}
