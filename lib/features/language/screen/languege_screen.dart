import 'package:asd_test/core/l10n/l10n.dart';
import 'package:asd_test/features/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title:
              Text(AppLocalizations.of(context)?.changeLanguage ?? 'Language'),
        ),
        body: ListView(
          children: L10n.all.map((local) {
            return ListTile(
              leading: Icon(Icons.language),
              trailing: Icon(localeLanguage == local
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off),
              onTap: () {
                BlocProvider.of<LanguageBloc>(context, listen: false)
                    .add(ChangeLanguageEvent(locale: local));
              },
              title: Center(
                child: Text(local.languageCode),
              ),
            );
          }).toList(),
        ));
  }
}
