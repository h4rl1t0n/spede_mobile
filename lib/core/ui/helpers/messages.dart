import 'package:flutter/material.dart';

import '../theme/styles/colors_app.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    _showSnackbarCustom(message: message, color: Colors.red);
  }

  void showErrorWithCloseButton(String message) {
    _showSnackbarCustom(
      message: message,
      textAlign: TextAlign.justify,
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      color: Colors.red,
      duration: const Duration(seconds: 20),
      closeButton: true,
    );
  }

  void showWarning(String message) {
    _showSnackbarCustom(message: message, color: Colors.orange[700]);
  }

  void showInfo(String message) {
    _showSnackbarCustom(message: message);
  }

  void showSuccess(String message) {
    _showSnackbarCustom(message: message, color: Colors.green);
  }

  void _showSnackbarCustom({
    required String message,
    Color? color,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
    Duration duration = const Duration(seconds: 4),
    bool closeButton = false,
    TextAlign textAlign = TextAlign.start,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
        behavior: SnackBarBehavior.floating,
        padding: padding,
        duration: duration,
        showCloseIcon: closeButton,
        backgroundColor: color ?? ColorsApp.instance.primary,
        content: Text(message, textAlign: textAlign),
      ),
    );
  }
}
