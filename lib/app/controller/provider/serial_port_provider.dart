import 'package:flutter/material.dart';
import 'package:test_for_serial_port/app/services/serial_service.dart';
class SerialPortProvider extends ChangeNotifier {
  final SerialPortService _serialPortService = SerialPortService();

  bool isSerialPortAvailable() {
    return _serialPortService.isSerialPortAvailable();
  }
}