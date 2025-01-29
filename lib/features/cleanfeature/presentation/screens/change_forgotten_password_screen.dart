import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/custom_spinning_progress_circular_indicator.dart';
import '../bloc/password_manager/clean_bloc.dart';

class ChangeForgottenPasswordScreen extends StatelessWidget {
  const ChangeForgottenPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05, horizontal: size.width * 0.05),
              child: SizedBox(
                width: size.width,
                child: _FormValidator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_left_sharp,
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)?.restorePassword ??
                    "Restore Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FormValidator extends StatefulWidget {
  const _FormValidator();
  @override
  State<_FormValidator> createState() => _FormValidatorState();
}

class _FormValidatorState extends State<_FormValidator> {
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final changePasswordFormKey = GlobalKey<FormState>();
    return BlocConsumer<CleanBloc, CleanState>(listener: (context, state) {
      if (state is PasswordManagerLoadingState) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Center(
                child: CustomSpinningCircularProgressIndicator(),
              ),
              surfaceTintColor: Colors.transparent,
            );
          },
        );
      } else if (state is PasswordManagerErrorState) {
        context.pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)?.thereWasAnError ??
                  'There was an error'),
              content: Text(state.errorStr),
            );
          },
        );
      } else if (state is PasswordManagerAcceptedState) {
        context.pop();
        context.go(RouterPaths.login);
      }
    }, builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _AppBar(),
          Form(
            key: changePasswordFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(AppLocalizations.of(context)?.password ?? 'Password'),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        color: Colors.grey[600],
                        height: 1,
                      ),
                    )
                  ],
                ),
                if (state.errorStr.isNotEmpty)
                  Text(
                    state.errorStr,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
