import 'package:flutter/material.dart';
import 'package:second_app/resources/app_values.dart';

enum SnackStatus { success, failed, info, warning }

class ErrorSnackbar {
  static void showErrorSnackbar(BuildContext context, String message, SnackStatus status) {
    final snackBarColor = getSnackBarColor(status);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white,fontSize: AppSize.s17),
        ),
        backgroundColor: snackBarColor,
      ),
    );
  }

  static Color getSnackBarColor(SnackStatus status) {
    switch (status) {
      case SnackStatus.success:
        return Colors.green;
      case SnackStatus.failed:
        return Colors.red;
      case SnackStatus.info:
        return Colors.blue;
      case SnackStatus.warning:
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
