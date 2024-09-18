import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_for_serial_port/app/views/home/home_page.dart';
import 'package:test_for_serial_port/app/views/landing/landing_page.dart';
import 'package:test_for_serial_port/app/views/landing/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
    r.module('/home', module: HomeModule());
  }
}

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute,
        child: (context) => const LandingPage(),
        children: [
          ChildRoute(
            '/home',
            child: (context) => const HomePage(),
          ),
        ]);
  }
}
