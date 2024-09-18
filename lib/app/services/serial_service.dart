import 'dart:async';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/list_helper.dart';

class SerialPortService {
  List<String> _availablePorts = [];
  final StreamController<List<String>> _controller =
      StreamController<List<String>>();

  Stream<List<String>> get portStream => _controller.stream;

  void startMonitoringPorts() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      final currentPorts = SerialPort.availablePorts;
      bool isListChanged = currentPorts.length != _availablePorts.length ||
          !ListHelper.listEquals(currentPorts, _availablePorts);

      if (isListChanged) {
        _availablePorts = currentPorts;
        _controller.add(currentPorts);
      }
    });
  }

  void dispose() {
    _controller.close();
  }

  bool isSerialPortAvailable() {
    return true;
  }
}
