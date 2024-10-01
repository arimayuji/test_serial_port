import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';

class SerialPortSelectionPage extends StatelessWidget {
  const SerialPortSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenha o SerialPortProvider do Modular
    final SerialPortProvider provider = Modular.get<SerialPortProvider>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SerialPortProvider>(
          create: (context) => provider,
        ),
      ],
      child: Scaffold(
        body: Consumer<SerialPortProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(height: 10),
                provider.availablePorts.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: provider.availablePorts.length,
                          itemBuilder: (context, index) {
                            String portName = provider.availablePorts[index];
                            bool isSelected = provider.selectedPort == portName;
                            bool isAnotherPortInUse =
                                provider.currentSensorId != null &&
                                    provider.selectedPort != portName;

                            return ListTile(
                              title: Text(
                                portName,
                                style: TextStyle(color: AppColors.primary),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!isSelected)
                                    IconButton(
                                      icon: const Icon(Icons.play_arrow),
                                      color: isAnotherPortInUse
                                          ? Colors
                                              .grey 
                                          : AppColors
                                              .primary, 
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
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'Nenhuma porta serial disponível',
                          style:
                              TextStyle(fontSize: 20, color: AppColors.primary),
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
                      const SizedBox(height: 10),
                      Text(
                        'Estado atual da porta: ${provider.state.inputMessage}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
