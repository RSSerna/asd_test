import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/language/screen/languege_screen.dart';
import '../../features/movies/presentation/screens/movies_screens.dart';
import 'router_paths.dart';

final router = GoRouter(
  initialLocation: RouterPaths.movies,
  routes: [
    //Password
    GoRoute(
      path: RouterPaths.movies,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    //Language
    GoRoute(
      path: RouterPaths.language,
      builder: (BuildContext context, GoRouterState state) =>
          const LanguageScreen(),
    ),
  ],
);
