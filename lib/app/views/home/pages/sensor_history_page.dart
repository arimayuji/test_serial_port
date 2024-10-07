import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/models/sensor_model.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';
import 'package:test_for_serial_port/app/views/home/widgets/sensor_widget.dart';

class SensorHistoryPage extends StatefulWidget {
  final String sensorId;
  const SensorHistoryPage({super.key, required this.sensorId});

  @override
  State<SensorHistoryPage> createState() => _SensorHistoryPageState();
}

class _SensorHistoryPageState extends State<SensorHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Histórico do sensor: ${widget.sensorId}',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: AppDimensions.fontMedium,
          ),
        ),
      ),
      body: Consumer<SerialPortProvider>(
        builder: (context, provider, child) {
          var result = provider.findSensorById(widget.sensorId);

          return result == null
              ? errorBuild(
                  context: context,
                  sensorId: widget.sensorId,
                )
              : successBuild(
                  sensor: result,
                );
        },
      ),
    );
  }
}

Widget successBuild({
  required SensorModel sensor,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return SensorWidget(
              sensorHistory: sensor.history[index],
            );
          },
          itemCount: sensor.history.length,
        ),
      )
    ],
  );
}

Widget errorBuild({required String sensorId, required BuildContext context}) {
  return Center(
    child: Text(
      'Erro ao carregar o histórico do sensor: $sensorId',
      style: Theme.of(context).textTheme.displayLarge,
    ),
  );
}
