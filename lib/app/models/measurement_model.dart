import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeasurementModel {
  final double moisture;
  final double temperature;
  final double pressure;
  final LatLng latLong;

  MeasurementModel(
      {required this.moisture,
      required this.temperature,
      required this.pressure,
      required this.latLong});
}
