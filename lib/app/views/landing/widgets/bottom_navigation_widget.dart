import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';

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
      Modular.to.navigate('/home/$route');
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomNavigationBarItem(
            key: 'HomeIconButton',
            icon: Icons.home,
            index: 0,
            route: 'forms',
          ),
          _buildBottomNavigationBarItem(
            key: 'PublicIconButton',
            icon: Icons.public,
            index: 1,
            route: 'map',
          ),
          const SizedBox(width: 48),
          _buildBottomNavigationBarItem(
            key: 'AddIconButton',
            icon: Icons.add,
            index: 2,
            route: 'create-form',
          ),
          _buildBottomNavigationBarItem(
            key: 'SettingsIconButton',
            icon: Icons.settings,
            index: 3,
            route: 'profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(
      {required String key,
      required IconData icon,
      required int index,
      required String route}) {
    return IconButton(
      alignment: Alignment.center,
      key: Key(key),
      icon: Icon(
        icon,
        color: _selectedIndex == index
            ? AppColors.secondary
            : AppColors.secondaryGrey,
        size: AppDimensions.iconLarge,
      ),
      onPressed: () => _onItemTapped(index, route),
    );
  }
}
