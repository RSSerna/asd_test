import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/language/screen/languege_screen.dart';
import 'router_paths.dart';
import 'routes.dart';

final router = GoRouter(
  initialLocation: RouterPaths.login,
  routes: [
    //Password
    GoRoute(
      path: RouterPaths.login,
      builder: (BuildContext context, GoRouterState state) =>
          const PasswordForgottenScreen(),
    ),
    //Language
    GoRoute(
      path: RouterPaths.language,
      builder: (BuildContext context, GoRouterState state) =>
          const LanguageScreen(),
    ),
  ],
);
