import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'core/l10n/l10n.dart';
import 'core/router/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/movies/presentation/providers/movies_provider.dart';
import 'features/settings/providers/language_provider.dart';
import 'features/settings/providers/theme_provider.dart';

class AppState extends StatelessWidget {
  final InjectionContainerImpl injectionContainerImpl;

  const AppState({
    super.key,
    required this.injectionContainerImpl,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => injectionContainerImpl.sl<MovieProvider>(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => injectionContainerImpl.sl<ThemeProvider>(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => injectionContainerImpl.sl<LanguageProvider>(),
        lazy: false,
      ),
    ], child: const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: context.watch<LanguageProvider>().currentLocale,
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'PointsIT',
      theme: AppTheme.themes[context.watch<ThemeProvider>().currentTheme],
    );
  }
}
