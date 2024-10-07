import 'package:flutter/material.dart';
import 'package:test_for_serial_port/app/models/measurement_history_model.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';

class SensorWidget extends StatefulWidget {
  final MeasurementHistory sensorHistory;
  const SensorWidget({super.key, required this.sensorHistory});

  @override
  State<SensorWidget> createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(
        10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingSmall,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              color: AppColors.primary,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Período da captação :',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.secondary,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.sensorHistory.sensor1Measurements.first.timestamp.toLocal()} - ${widget.sensorHistory.sensor1Measurements.last.timestamp.toLocal()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppDimensions.paddingMedium,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Medições :',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Média Sensor 0:',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${widget.sensorHistory.sensor1MeasurementsAverage}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Primeiro Valor:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${widget.sensorHistory.sensor1Measurements.first.value}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ultimo Valor:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${widget.sensorHistory.sensor1Measurements.last.value}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Média Sensor 2:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${widget.sensorHistory.sensor2MeasurementsAverage}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Primeiro Valor:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${widget.sensorHistory.sensor2Measurements.first.value}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ultimo Valor:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${widget.sensorHistory.sensor1Measurements.last.value}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
