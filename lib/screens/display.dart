import 'package:flutter/material.dart';
import 'package:task/components/unfocus_on_tap.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnFocusOnTap(child: Scaffold());
  }
}
