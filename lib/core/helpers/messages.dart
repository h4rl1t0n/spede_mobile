import 'package:flutter/material.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    _showSnackbarCustom(message: message, color: Colors.red);
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

  void _showSnackbarCustom({required String message, Color? color}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          content: Text(message, textAlign: TextAlign.justify),
          backgroundColor: color,
          action: SnackBarAction(
            label: 'Fechar',
            textColor: Colors.white,
            onPressed: () {
              scaffoldMessenger.hideCurrentSnackBar();
            },
          ),
        ),
      );
  }
}
