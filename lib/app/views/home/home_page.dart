import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';
import 'package:test_for_serial_port/app/shared/themes/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SerialPortProvider serialPortProvider =
      Modular.get<SerialPortProvider>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        serialPortIcon(
          serialPortProvider.isSerialPortAvailable(),
        )
      ],
    );
  }

  Widget serialPortIcon(bool isConnected) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      color: isConnected ? AppColors.primary : AppColors.secondaryGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          isConnected ? AppIcons.connectIcon : AppIcons.connectIconSecondary
        ],
      ),
    );
  }
}
