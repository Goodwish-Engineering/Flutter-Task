import 'package:app/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(BuildContext context, String placeholder, String value) {
  Clipboard.setData(ClipboardData(text: value));
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text('$placeholder copied to clipboard'),
  //     duration: Duration(seconds: 2),
  //   ),
  // );

  showSnackbar(context, '$placeholder copied to clipboard');
}
