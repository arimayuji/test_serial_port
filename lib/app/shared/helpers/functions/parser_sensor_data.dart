import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:test_for_serial_port/app/models/measurement_model.dart';

// Função para processar os dados recebidos da porta serial
Future<List<MeasurementModel>> processSerialData(Uint8List data, Position? position) async {
  if (data.length != 6 || data[5] != 13) {
    throw Exception('Formato inválido de dados recebidos.');
  }

  final int sensorId = data[0]; // ID do sensor
  final int sensor1Value = (data[1] << 8) | data[2]; // Valor do sensor 1
  final int sensor2Value = (data[3] << 8) | data[4]; // Valor do sensor 2
  final DateTime now = DateTime.now();

  // Obter a localização atual (já passada por parâmetro)
  double? latitude = position?.latitude;
  double? longitude = position?.longitude;

  // Criar os objetos MeasurementModel para os dois sensores
  MeasurementModel measurement1 = MeasurementModel(
    sensorId: sensorId,
    value: sensor1Value.toDouble(),
    timestamp: now,
    latitude: latitude,
    longitude: longitude,
  );

  MeasurementModel measurement2 = MeasurementModel(
    sensorId: sensorId,
    value: sensor2Value.toDouble(),
    timestamp: now,
    latitude: latitude,
    longitude: longitude,
  );

  // Retorna os dois MeasurementModels em uma lista
  return [measurement1, measurement2];
}
