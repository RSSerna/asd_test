import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'core/l10n/l10n.dart';
import 'core/router/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/language/bloc/language_bloc.dart';
import 'features/movies/presentation/providers/movies_provider.dart';

class AppState extends StatelessWidget {
  final InjectionContainerImpl injectionContainerImpl;

  const AppState({
    super.key,
    required this.injectionContainerImpl,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (context) => injectionContainerImpl.sl<LanguageBloc>(),
        ),
      ],
      child: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => injectionContainerImpl.sl<MovieProvider>(),
          lazy: false,
        )
      ], child: const MainApp()),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          locale: state.locale,
          supportedLocales: L10n.all,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: 'PointsIT',
          theme: AppTheme.ligthTheme,
        );
      },
    );
  }
}
