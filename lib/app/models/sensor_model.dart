import 'package:test_for_serial_port/app/models/meter_model.dart';

class SensorModel {
  final String id;
  final MeterModel meter_0;
  final MeterModel meter_1;

  SensorModel({required this.id})
      : meter_0 = MeterModel(sensorId: id), 
        meter_1 = MeterModel(sensorId: id); 
}
