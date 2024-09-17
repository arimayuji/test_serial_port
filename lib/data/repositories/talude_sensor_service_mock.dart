// // services/talude_sensor_service_mock.dart
// import 'dart:async';

// class TaludeSensorServiceMock {
//   StreamController<String> _controller = StreamController<String>();

//   Stream<String> get dataStream => _controller.stream;

//   void simulateData() {
//     // Simular dados de sensor periodicamente
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       final simulatedData = '25.5, 10.2'; // Exemplo de dados simulados
//       _controller.add(simulatedData);
//     });
//   }

//   void dispose() {
//     _controller.close();
//   }
// }
