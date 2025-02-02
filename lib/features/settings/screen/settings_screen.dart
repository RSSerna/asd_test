import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeLanguage = Localizations.localeOf(context);

    return Scaffold(
        appBar: AppBar(
          leading: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          title: Text(AppLocalizations.of(context)?.settings ?? 'Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ThemeSwitch(),
              Text(AppLocalizations.of(context)?.change_language ??
                  'Change Language'),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: AppLocalizations.of(context)?.language ?? 'Language',
                  ),
                  TextSpan(text: ': '),
                  TextSpan(
                    text: AppLocalizations.of(context)?.actual_language ??
                        'English',
                  ),
                ]),
              ),
              Expanded(
                // height: 500,
                child: ListView(
                  children: L10n.all.map((locale) {
                    return ListTile(
                      leading: Icon(Icons.language),
                      trailing: Icon(localeLanguage == locale
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off),
                      onTap: () {
                        context.read<LanguageProvider>().setLocale(locale);
                      },
                      title: Center(
                        child: Text(locale.languageCode),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}

class _ThemeSwitch extends StatelessWidget {
  const _ThemeSwitch();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var currentTheme = context.watch<ThemeProvider>().currentTheme;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: AppLocalizations.of(context)?.theme ?? 'Theme',
              ),
              TextSpan(text: ' '),
              TextSpan(
                text: currentTheme == AppThemeType.dark
                    ? AppLocalizations.of(context)?.dark ?? 'Dart'
                    : AppLocalizations.of(context)?.light ?? 'Light',
              ),
            ]),
          ),
          Switch(
            value: currentTheme == AppThemeType.dark,
            onChanged: (value) {
              context
                  .read<ThemeProvider>()
                  .setTheme(value ? AppThemeType.dark : AppThemeType.light);
            },
          ),
        ],
      );
    });
  }
}
