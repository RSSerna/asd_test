import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_paths.dart';

class PasswordForgottenScreen extends StatelessWidget {
  const PasswordForgottenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.0125,
                  horizontal: size.width * 0.05),
              child: SizedBox(
                width: size.width,
                child: Column(
                  children: [
                    const _AppBar(),
                    _ImageAndInfo(size: size),
                    _EmailVerifyWidget(onAccepted: (token) {
                      context.go(RouterPaths.login);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class _ImageAndInfo extends StatelessWidget {
  const _ImageAndInfo({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(30),
          height: 130,
          width: size.width,
          color: Colors.lightBlue,
          child: Container(
              color: Colors.lightBlueAccent,
              child: const Center(child: Text("Image"))),
        ),
        Text(AppLocalizations.of(context)?.recoverPasswordInfo ??
            'To recover your password enter your email and follow instructions'),
      ],
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
                onPressed: () {
                  context.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left_sharp,
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)?.recoverPasswordTitle ??
                    "Recover password",
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

class _EmailVerifyWidget extends StatelessWidget {
  const _EmailVerifyWidget({required this.onAccepted});
  final Function(String token) onAccepted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _FormValidator(
                onAccepted: onAccepted,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FormValidator extends StatefulWidget {
  const _FormValidator({required this.onAccepted});
  final Function(String token) onAccepted;
  @override
  State<_FormValidator> createState() => _FormValidatorState();
}

class _FormValidatorState extends State<_FormValidator> {
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
