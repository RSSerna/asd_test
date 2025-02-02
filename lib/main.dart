import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'core/environment/environment.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String env =
      String.fromEnvironment("APP_CONFIG_ENV", defaultValue: "dev");
  switch (env) {
    case 'production':
      AppEnvironment.setupEnv(Environment.production);
      break;
    case 'staging':
      AppEnvironment.setupEnv(Environment.staging);
      break;
    default:
      AppEnvironment.setupEnv(Environment.develop);
  }

  final injectionContainerImpl = InjectionContainerImpl();
  await injectionContainerImpl.init();
  runApp(AppState(injectionContainerImpl: injectionContainerImpl));
}
