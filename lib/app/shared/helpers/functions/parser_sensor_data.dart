import 'package:geolocator/geolocator.dart';
import 'package:test_for_serial_port/app/models/measurement_model.dart';

Future<List<MeasurementModel>> processSerialData(
  String lineData,
  Position? position,
) async {
  // Dividimos a linha de dados pelos espaços para separar os valores
  List<String> dataParts = lineData.trim().split(' ');

  // Verifica se temos exatamente 3 partes: id, número, número
  if (dataParts.length != 3) {
    throw Exception('Formato de dados inválido');
  }

  // Extrai o ID do sensor e as medições
  final int sensorId = int.parse(dataParts[0]); // ID do sensor
  final double sensor1Value =
      double.parse(dataParts[1]); // Valor do primeiro medidor
  final double sensor2Value =
      double.parse(dataParts[2]); // Valor do segundo medidor

  // Cria dois MeasurementModels, um para cada medidor
  List<MeasurementModel> measurements = [
    MeasurementModel(
      sensorId: sensorId,
      value: sensor1Value,
      timestamp: DateTime.now(),
      latitude: position?.latitude,
      longitude: position?.longitude,
    ),
    MeasurementModel(
      sensorId: sensorId,
      value: sensor2Value,
      timestamp: DateTime.now(),
      latitude: position?.latitude,
      longitude: position?.longitude,
    ),
  ];

  return measurements;
}
