import 'package:test_for_serial_port/app/models/measurement_model.dart';
import 'package:test_for_serial_port/app/shared/helpers/models/measurement_helper_model.dart';

class MeasurementHistory {
  final String sensorId;
  final List<MeasurementModel>
      sensor1Measurements; // Histórico de medições do sensor 1
  final List<MeasurementModel>
      sensor2Measurements; // Histórico de medições do sensor 2

  MeasurementHistory({
    required this.sensorId,
    required this.sensor1Measurements,
    required this.sensor2Measurements,
  });

  double get sensor1MeasurementsAverage =>
      MeasurementHelper.calculateAverage(sensor1Measurements);
      
  double get sensor2MeasurementsAverage =>
      MeasurementHelper.calculateAverage(sensor2Measurements);
}
