import 'dart:async';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:test_for_serial_port/app/shared/helpers/functions/global_snackbar.dart';

class SerialPortReaderService {
  SerialPort? _port;
  SerialPortReaderService();

  bool openPort(String portName) {
    _port = SerialPort(portName);

    if (_port!.openReadWrite()) {
      return true;
    } else {
      return false;
    }
  }

  Stream<List<int>> startReading() async* {
    if (_port == null || !_port!.isOpen) {
      GlobalSnackBar.error("Porta serial inexistente");
    }

    GlobalSnackBar.success("Porta serial aberta");

    final reader = SerialPortReader(_port!);

    await for (final data in reader.stream) {
      yield data;
    }
  }

  void closePort() {
    if (_port != null && _port!.isOpen) {
      _port!.close();
    }
  }
}
