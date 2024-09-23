import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitor Serial',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exibe o ícone baseado no estado do SerialPortProvider
          Consumer<SerialPortProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  IconButton(
                    color: _getIconColorForState(provider.state),
                    onPressed: () {},
                    icon: _getIconForState(provider.state),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _getMessageForState(
                        provider.state), // Mensagem do estado atual
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Retorna o ícone de acordo com o estado do SerialPortState
  Icon _getIconForState(SerialPortState state) {
    switch (state) {
      case SerialPortState.noPortFound:
        return AppIcons
            .noConnectIcon; // Ícone quando a porta não foi encontrada
      case SerialPortState.portFound:
        return AppIcons.connectIcon; // Ícone quando a porta foi encontrada
      case SerialPortState.portDisconnected:
        return AppIcons.noConnectIcon; // Ícone quando a porta foi desconectada
      default:
        return AppIcons.errorIconSecondary; // Ícone para estado desconhecido
    }
  }

  // Retorna a cor do ícone de acordo com o estado do SerialPortState
  Color _getIconColorForState(SerialPortState state) {
    switch (state) {
      case SerialPortState.noPortFound:
        return AppColors.error; // Cor para porta não encontrada
      case SerialPortState.portFound:
        return AppColors.success; // Cor para porta encontrada
      case SerialPortState.portDisconnected:
        return AppColors.orange; // Cor para porta desconectada
      default:
        return AppColors.secondaryGrey; // Cor para estado desconhecido
    }
  }

  // Retorna a mensagem baseada no estado atual do SerialPortState
  String _getMessageForState(SerialPortState state) {
    switch (state) {
      case SerialPortState.noPortFound:
        return 'Nenhuma porta encontrada';
      case SerialPortState.portFound:
        return 'Porta encontrada e conectada';
      case SerialPortState.portDisconnected:
        return 'Porta desconectada';
      default:
        return 'Estado desconhecido';
    }
  }
}
