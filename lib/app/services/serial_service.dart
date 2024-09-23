import 'dart:async';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/global_snackbar.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/list_helper.dart';

enum SerialPortState {
  noPortFound,
  portFound,
  portDisconnected,
}

class SerialPortService {
  List<String> _availablePorts = [];
  SerialPort? _activePort; // Porta serial ativa
  StreamSubscription<List<int>>? _dataSubscription; // Para ler os dados continuamente
  final StreamController<List<String>> _controller = StreamController<List<String>>();
  final StreamController<SerialPortState> _stateController = StreamController<SerialPortState>();
  final StreamController<List<int>> _dataController = StreamController<List<int>>(); // Controlador para os dados lidos

  Stream<List<String>> get portStream => _controller.stream;
  Stream<SerialPortState> get stateStream => _stateController.stream;
  Stream<List<int>> get dataStream => _dataController.stream; // Stream de dados lidos

  SerialPortState _currentState = SerialPortState.noPortFound;

  void startMonitoringPorts() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      final currentPorts = SerialPort.availablePorts;
      bool isListChanged = currentPorts.length != _availablePorts.length ||
          !ListHelper.listEquals(currentPorts, _availablePorts);

      if (isListChanged) {
        _availablePorts = currentPorts;
        _controller.add(currentPorts);

        // Atualizar o estado da conexão com base nas portas disponíveis
        if (_availablePorts.isEmpty && _currentState != SerialPortState.noPortFound) {
          _currentState = SerialPortState.noPortFound;
          _stateController.add(SerialPortState.noPortFound);
          closeActivePort(); // Fecha a porta se todas foram desconectadas
          GlobalSnackBar.error('Nenhuma porta encontrada'); // Mostra o erro de porta não encontrada
        } else if (_availablePorts.isNotEmpty && _currentState != SerialPortState.portFound) {
          _currentState = SerialPortState.portFound;
          _stateController.add(SerialPortState.portFound);
          GlobalSnackBar.success('Porta encontrada!'); // Mostra sucesso quando a porta é encontrada
        }
      }
    });
  }

  // Abre a porta serial selecionada e inicia a leitura de dados
  bool openPort(String portName) {
    _activePort = SerialPort(portName);

    if (_activePort!.openReadWrite()) {
      GlobalSnackBar.success('Porta $portName aberta com sucesso'); // Sucesso ao abrir a porta
      startReadingData(); // Começa a ler dados
      return true;
    } else {
      GlobalSnackBar.error('Erro ao abrir a porta $portName'); // Erro ao abrir a porta
      return false;
    }
  }

  // Inicia a leitura contínua de dados da porta serial
  void startReadingData() {
    final reader = SerialPortReader(_activePort!);
    
    _dataSubscription = reader.stream.listen((data) {
      _dataController.add(data); // Adiciona os dados lidos ao stream
      GlobalSnackBar.success('Dados recebidos da porta serial'); // Sucesso ao receber dados
    }, onError: (error) {
      GlobalSnackBar.error('Erro ao ler dados da porta: $error'); // Mostra erro durante a leitura
    }, onDone: () {
      GlobalSnackBar.success('Leitura de dados encerrada'); // Mostra quando a leitura é finalizada
    });
  }

  // Fecha a porta ativa
  void closeActivePort() {
    _dataSubscription?.cancel();
    if (_activePort != null && _activePort!.isOpen) {
      _activePort!.close();
      _activePort = null;
      GlobalSnackBar.success('Porta serial fechada'); // Mostra que a porta foi fechada
    }
  }

  void dispose() {
    _controller.close();
    _stateController.close();
    _dataController.close();
    closeActivePort();
  }

  bool isSerialPortAvailable() {
    return _availablePorts.isNotEmpty;
  }
}
