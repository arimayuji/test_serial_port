// import 'package:flutter/material.dart';
// import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';

// class SensorWidget extends StatefulWidget {
//   // final MeterModel meterModel;
//   const SensorWidget({super.key, required this.meterModel});

//   @override
//   State<SensorWidget> createState() => _SensorWidgetState();
// }

// class _SensorWidgetState extends State<SensorWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(
//             widget.meterModel.sensorId,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(color: AppColors.primary),
//           ),
//           Text(
//             '${widget.meterModel.average}',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(color: AppColors.primary),
//           ),
//         ],
//       ),
//     );
//   }
// }
