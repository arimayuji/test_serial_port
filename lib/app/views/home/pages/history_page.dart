import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SerialPortProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Históricos',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: AppDimensions.fontMedium,
              ),
            ),
            backgroundColor: AppColors.primary,
            centerTitle: true,
          ),
          body: provider.sensors.isEmpty
              ? errorBuild(provider)
              : successBuild(provider),
        );
      },
    );
  }

  Widget successBuild(SerialPortProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: AppDimensions.verticalSpaceMedium,
              );
            },
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge * 3,
              vertical: AppDimensions.paddingLarge,
            ),
            itemCount: provider.sensors.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(
                  bottom: AppDimensions.marginSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Sensor ID: ${provider.sensors[index].id.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: AppColors.primary,
                              ),
                        ),
                        TextButton(
                          onPressed: () {
                            Modular.to.navigate(
                                '/home/history/${provider.sensors[index].id}');
                          },
                          child: Text(
                            'Clique para ver o histórico',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: AppColors.secondaryGrey,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.secondaryGrey,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget errorBuild(SerialPortProvider provider) {
    return Center(
      child: Text(provider.sensors.toString(),
          style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
