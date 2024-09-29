import 'package:flutter/material.dart';
import 'package:test_for_serial_port/app/models/sensor_model.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';

class SensorWidget extends StatefulWidget {
  final SensorModel sensorModel;
  const SensorWidget({super.key, required this.sensorModel});

  @override
  State<SensorWidget> createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe o ID do sensor
            Text(
              'Sensor ID: ${widget.sensorModel.id}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 10),
            Text(
              'Histórico de medições:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200, 
              child: ListView.builder(
                itemCount: widget.sensorModel.history.length,
                itemBuilder: (context, index) {
                  final measurementHistory = widget.sensorModel.history[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Momento ${index + 1}:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text('Medição 1: ${measurementHistory.sensor1Measurements.map((m) => m.value).join(', ')}'),
                      Text('Medição 2: ${measurementHistory.sensor2Measurements.map((m) => m.value).join(', ')}'),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
