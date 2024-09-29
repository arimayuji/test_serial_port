import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_icons.dart';
import 'package:test_for_serial_port/app/views/home/state/measurement_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teste Serial Port',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<SerialPortProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  IconButton(
                    color: _getIconColorForState(
                      provider.state,
                    ),
                    onPressed: () {},
                    icon: _getIconForState(
                      provider.state,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Icon _getIconForState(InputState state) {
    if (state is InputWaitingConnectionState) {
      return AppIcons.noConnectIcon;
    } else if (state is InputEstablishingConnectionState) {
      return AppIcons.connectIcon;
    } else if (state is InputCapturingDataState) {
      return AppIcons.connectIcon;
    } else {
      return AppIcons.noConnectIcon;
    }
  }

  Color _getIconColorForState(InputState state) {
    if (state is InputWaitingConnectionState) {
      return AppColors.secondaryGrey;
    } else if (state is InputEstablishingConnectionState) {
      return AppColors.orange;
    } else if (state is InputCapturingDataState) {
      return AppColors.success;
    } else {
      return AppColors.error;
    }
  }
}
