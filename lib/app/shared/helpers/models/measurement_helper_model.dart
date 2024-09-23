import 'package:test_for_serial_port/app/models/measurement_model.dart';

class MeasurementHelper {
  static double calculateAverage(List<MeasurementModel> measurements) {
    if (measurements.isEmpty) return 0;
    return measurements.map((m) => m.value).reduce((a, b) => a + b) / measurements.length;
  }

  static MeasurementModel? getFirstMeasurement(List<MeasurementModel> measurements) {
    return measurements.isNotEmpty ? measurements.first : null;
  }

  static MeasurementModel? getLastMeasurement(List<MeasurementModel> measurements) {
    return measurements.isNotEmpty ? measurements.last : null;
  }
}
