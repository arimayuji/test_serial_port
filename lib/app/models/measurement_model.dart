class MeasurementModel {
  final int sensorId; 
  final double value; 
  final DateTime timestamp; 
  final double? latitude; 
  final double? longitude; 
  
  MeasurementModel({
    required this.sensorId,
    required this.value,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
  });
}
