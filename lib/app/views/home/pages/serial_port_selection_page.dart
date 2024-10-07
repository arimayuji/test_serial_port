import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';

class SerialPortSelectionPage extends StatefulWidget {
  const SerialPortSelectionPage({super.key});

  @override
  State<SerialPortSelectionPage> createState() =>
      _SerialPortSelectionPageState();
}

class _SerialPortSelectionPageState extends State<SerialPortSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SerialPortProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: Text(
              'Selecione a porta serial para começar a leitura',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: AppDimensions.fontMedium,
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              provider.availablePorts.isNotEmpty
                  ? Expanded(
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
                        physics: const BouncingScrollPhysics(),
                        itemCount: provider.availablePorts.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          String portName = provider.availablePorts[index];
                          bool isSelected = provider.selectedPort == portName;
                          bool isAnotherPortInUse =
                              provider.selectedPort != null && isSelected;
                          return SizedBox(
                            width: double.infinity * 0.5,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingSmall,
                                vertical: AppDimensions.paddingSmall,
                              ),
                              tileColor: AppColors.primary,
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                'Porta serial: $portName',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: AppDimensions.fontLarge,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!isSelected)
                                    IconButton(
                                      alignment: Alignment.topLeft,
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          Colors.white,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: AppColors.primary,
                                        size: AppDimensions.iconLarge,
                                      ),
                                      color: isAnotherPortInUse
                                          ? Colors.grey
                                          : AppColors.primary,
                                      onPressed: isAnotherPortInUse
                                          ? null
                                          : () {
                                              provider.selectPort(portName);
                                            },
                                    ),
                                  if (isSelected)
                                    IconButton(
                                      icon: const Icon(Icons.stop),
                                      color: Colors.red,
                                      onPressed: () {
                                        provider.stopReading();
                                      },
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'Nenhuma porta serial disponível',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              if (provider.selectedPort != null)
                Column(
                  children: [
                    Text(
                      'Porta Selecionada: ${provider.selectedPort}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Estado atual da porta: ${provider.state.inputMessage}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
