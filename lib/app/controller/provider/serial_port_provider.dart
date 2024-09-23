import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_for_serial_port/app/models/measurement_history_model.dart';
import 'package:test_for_serial_port/app/models/measurement_model.dart';
import 'package:test_for_serial_port/app/services/location_service.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/global_snackbar.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/parser_sensor_data.dart';

enum SerialPortState {
  noPortFound,
  portFound,
  portDisconnected,
}

class SerialPortProvider extends ChangeNotifier {
  final SerialPort port;
  SerialPortState _state = SerialPortState.noPortFound;
  Timer? _monitoringTimer;
  StreamSubscription? _portSubscription;
  List<int> buffer = [];
  List<MeasurementHistory> sensorHistory = [];
  final LocationService locationService =
      LocationService(); // Instância do LocationService

  SerialPortProvider(this.port);

  SerialPortState get state => _state;
  List<MeasurementHistory> get currentMeasurements => sensorHistory;

  // Inicia o monitoramento da porta serial quando a aplicação é aberta
  void startMonitoring() {
    _monitoringTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkConnection();
    });
  }

  // Verifica se a porta serial está conectada
  void _checkConnection() {
    if (port.isOpen) {
      if (_state != SerialPortState.portFound) {
        _updateState(SerialPortState.portFound);
        _startReading();
      }
    } else {
      if (_state == SerialPortState.portFound ||
          _state == SerialPortState.portDisconnected) {
        _updateState(SerialPortState.noPortFound);
        _stopReading();
      }
    }
  }

  // Atualiza o estado da conexão e exibe um SnackBar
  void _updateState(SerialPortState newState) {
    _state = newState;
    notifyListeners();

    // Exibir um Global SnackBar com base no novo estado
    switch (newState) {
      case SerialPortState.noPortFound:
        GlobalSnackBar.error('Nenhuma porta encontrada');
        break;
      case SerialPortState.portFound:
        GlobalSnackBar.success('Porta encontrada e conectada');
        break;
      case SerialPortState.portDisconnected:
        GlobalSnackBar.info('Porta desconectada');
        break;
    }
  }

  // Inicia a leitura dos dados da porta serial
  void _startReading() {
    if (!port.openReadWrite()) {
      throw Exception('Erro ao abrir a porta serial');
    }

    final reader = SerialPortReader(port);
    _portSubscription = reader.stream.listen((data) async {
      buffer.addAll(data);
      if (buffer.length >= 6 && buffer[5] == 13) {
        // Obter a localização atual
        Position? position = await locationService.getCurrentLocation();

        // Processa os dados usando a função separada
        List<MeasurementModel> measurements =
            await processSerialData(Uint8List.fromList(buffer), position);

        // Armazena as medições em um novo histórico
        sensorHistory.add(
          MeasurementHistory(
            sensorId: measurements.first.sensorId.toString(),
            sensor1Measurements: [measurements[0]],
            sensor2Measurements: [measurements[1]],
          ),
        );

        buffer.clear();
        notifyListeners(); // Notifica a interface sobre novos dados
      }
    });
  }

  // Para a leitura quando a conexão é perdida
  void _stopReading() {
    _portSubscription?.cancel();
    port.close();
    _updateState(SerialPortState.portDisconnected);
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
