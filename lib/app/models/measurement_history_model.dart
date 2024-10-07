import 'package:test_for_serial_port/app/models/measurement_model.dart';
import 'package:test_for_serial_port/app/shared/helpers/models/measurement_helper_model.dart';

class MeasurementHistory {
  final String sensorId;
  final List<MeasurementModel>
      sensor1Measurements; 
  final List<MeasurementModel>
      sensor2Measurements; 

  MeasurementHistory({
    required this.sensorId,
    required this.sensor1Measurements,
    required this.sensor2Measurements,
  });

  double get sensor1MeasurementsAverage =>
      MeasurementHelper.calculateAverage(sensor1Measurements);

  double get sensor2MeasurementsAverage =>
      MeasurementHelper.calculateAverage(sensor2Measurements);

  DateTime get sensor1MeasurementsLastTimestamp =>
      MeasurementHelper.getLastMeasurement(sensor1Measurements)?.timestamp ??
      DateTime.now();

  DateTime get sensor2MeasurementsLastTimestamp =>
      MeasurementHelper.getLastMeasurement(sensor2Measurements)?.timestamp ??
      DateTime.now();
}
