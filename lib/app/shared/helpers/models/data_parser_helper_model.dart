import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';
import 'package:test_for_serial_port/app/models/measurement_model.dart';
import 'package:test_for_serial_port/app/services/location_service.dart';

class DataParser {
  static Future<List<MeasurementModel>> parseData(Uint8List data) async {
    if (data.length != 6 || data[5] != 13) {
      throw Exception('Formato inválido de dados recebidos.');
    }

    final int sensorId = data[0]; // ID do sensor
    final int meter1Value = (data[1] << 8) | data[2]; // Valor do medidor 1
    final int meter2Value = (data[3] << 8) | data[4]; // Valor do medidor 2
    final DateTime now = DateTime.now();

    Position? position = await LocationService().getCurrentLocation();
    double? latitude = position?.latitude;
    double? longitude = position?.longitude;

    MeasurementModel sensor1Measurement = MeasurementModel(
      sensorId: sensorId,
      value: meter1Value.toDouble(),
      timestamp: now,
      latitude: latitude,
      longitude: longitude,
    );

    MeasurementModel sensor2Measurement = MeasurementModel(
      sensorId: sensorId,
      value: meter2Value.toDouble(),
      timestamp: now,
      latitude: latitude,
      longitude: longitude,
    );

    return [sensor1Measurement, sensor2Measurement];
  }
}