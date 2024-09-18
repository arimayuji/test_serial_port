import 'package:test_for_serial_port/app/models/measurement_model.dart';

class MeterModel {
  final String sensorId;
  List<MeasurementModel> measurements = [];

  MeterModel({required this.sensorId});
}
