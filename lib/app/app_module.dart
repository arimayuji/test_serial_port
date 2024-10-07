import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/views/home/pages/history_page.dart';
import 'package:test_for_serial_port/app/views/home/pages/sensor_history_page.dart';
import 'package:test_for_serial_port/app/views/home/pages/serial_port_selection_page.dart';
import 'package:test_for_serial_port/app/views/landing/landing_page.dart';
import 'package:test_for_serial_port/app/views/landing/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      duration: const Duration(seconds: 3),
      child: (context) => const SplashPage(),
    );
    r.module(
      '/home',
      module: HomeModule(),
    );
  }
}

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<SerialPortProvider>(SerialPortProvider.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const LandingPage(),
      children: [
        ChildRoute('/history',
            child: (context) => const HistoryPage(),
            transition: TransitionType.fadeIn),
        ChildRoute('/home',
            child: (context) => const SerialPortSelectionPage(),
            transition: TransitionType.fadeIn),
        ChildRoute(
          '/history/:id',
          child: (context) => SensorHistoryPage(
            sensorId: r.args.params['id'],
          ),
        )
      ],
    );
  }
}
