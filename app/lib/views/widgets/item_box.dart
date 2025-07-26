import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple, Colors.black],
        ),
      ),
    );
  }
}
