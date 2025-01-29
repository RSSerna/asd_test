import 'package:flutter/material.dart';

class CustomSpinningCircularProgressIndicator extends StatelessWidget {
  const CustomSpinningCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 5,
      backgroundColor: Colors.white70,
    );
  }
}
