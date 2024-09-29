import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/views/home/widgets/sensor_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final provider = Modular.get<SerialPortProvider>();
  @override
  Widget build(BuildContext context) {
    return Consumer<SerialPortProvider>(
      builder: (context, provider, child) {
        return provider.sensors.isEmpty ? errorBuild() : successBuild();
      },
    );
  }

  Widget successBuild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Histórico',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return SensorWidget(
              sensorModel: provider.sensors[index],
            );
          },
          itemCount: provider.sensors.length,
        )
      ],
    );
  }

  Widget errorBuild() {
    return Center(
      child: Text('No data found',
          style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
