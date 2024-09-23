import 'package:test_for_serial_port/app/models/measurement_history_model.dart';

class SensorModel {
  final String id;
  List<MeasurementHistory> history = [];

  SensorModel({required this.id, required this.history});
}
