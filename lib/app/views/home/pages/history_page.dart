// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:provider/provider.dart';
// import 'package:test_for_serial_port/app/app_module.dart';
// import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
// import 'package:test_for_serial_port/app/models/meter_model.dart';
// import 'package:test_for_serial_port/app/views/home/widgets/sensor_widget.dart';

// class HistoryPage extends StatefulWidget {
//   const HistoryPage({super.key});

//   @override
//   State<HistoryPage> createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return   Consumer<SerialPortProvider>(builder: (_, provider, child) {
//       return state is FormUserErrorState
//           ? errorBuild(state.error)
//           : state is FormUserSuccessState
//               ? successBuild(state.forms)
//               : const Center(child: CircularProgressIndicator());
//     });
//   }

//   Widget successBuild (){
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Text(
//           'Histórico',
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//         ListView.builder(
//           itemBuilder: (context, index) {
//             MeterModel sensorMeter = context
//             return SensorWidget(
//                 meterModel:
//                     context.watch<SerialPortProvider>().measurements[index].);
//           },
//           itemCount: context.watch<SerialPortProvider>().measurements!.length,
//         )
//       ],
//     );
//   }

//     Widget errorBuild() {
//     return Center(
//       child: Text('No data found', style: Theme.of(context).textTheme.displayLarge),
//     );
//   }
// }
