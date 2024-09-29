import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/controller/provider/serial_port_provider.dart';
import 'package:test_for_serial_port/app/views/home/pages/history_page.dart';
import 'package:test_for_serial_port/app/views/home/pages/home_page.dart';
import 'package:test_for_serial_port/app/views/home/pages/serial_port_selection_page.dart';
import 'package:test_for_serial_port/app/views/landing/landing_page.dart';
import 'package:test_for_serial_port/app/views/landing/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
    r.module('/home', module: HomeModule());
  }
}

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<SerialPortProvider>(SerialPortProvider.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute,
        child: (context) => const LandingPage(),
        children: [
          ChildRoute(
            '/home',
            child: (context) => const HomePage(),
          ),
          ChildRoute(
            '/history',
            child: (context) => const HistoryPage(),
          ),
          ChildRoute(
            '/serial_port_selection',
            child: (context) => const SerialPortSelectionPage(),
          ),
        ]);
  }
}
