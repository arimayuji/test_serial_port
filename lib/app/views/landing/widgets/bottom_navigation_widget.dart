import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_icons.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override   
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, String route) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      Modular.to.navigate('/home$route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.primary,
      surfaceTintColor: AppColors.primary,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavigationBarItem(
            icon: AppIcons.homeIconSecondary,
            index: 0,
            route: '/home',
          ),
          _buildBottomNavigationBarItem(
            icon: AppIcons.historyIconSecondary,
            index: 1,
            route: '/history',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(
      {required Icon icon, required int index, required String route}) {
    return IconButton(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppColors.secondary),
      ),
      alignment: Alignment.center,
      color: AppColors.secondary,
      icon: icon,
      onPressed: () => _onItemTapped(index, route),
    );
  }
}
