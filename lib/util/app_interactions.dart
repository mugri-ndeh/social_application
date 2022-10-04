import 'package:flutter/material.dart';

class AppInteractions {
  static showLoading() {}
  static hideLoading() {}
  static showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade200,
          content: Text(message),
        ),
      );
  }

  // helper method to show alert dialog
  static showAlertDialog(
      BuildContext context, String title, String content, Function() action) {
    // set up the AlertDialog
    Widget okButton = TextButton(onPressed: action, child: const Text("OK"));
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(message),
        ),
      );
  }
}
