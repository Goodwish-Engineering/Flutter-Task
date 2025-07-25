import 'package:flutter/material.dart';

class ScreenWithBackground extends StatelessWidget {
  final Widget child; // your screen content

  const ScreenWithBackground({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/home.jpg', fit: BoxFit.cover),
        ),
        child,
      ],
    );
  }
}
