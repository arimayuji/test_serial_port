import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/app_module.dart';
import 'package:test_for_serial_port/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
