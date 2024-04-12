import 'package:flutter/material.dart';
import 'package:habits24/domain/domain.dart';

abstract class AppSnackBar {
  static void showSnackBarWithError(BuildContext context, ErrorEntity error) {
    clearSnackBars(context);
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent.shade100,
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(
            'Ошибка: ${error.message}, Cообщение: ${error.errorMessage}',
            maxLines: 5,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  static void showSnackBarWithMessage(BuildContext context, String message) {
    clearSnackBars(context);
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade100,
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(
            message,
            maxLines: 5,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  static void clearSnackBars(BuildContext context) {
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
  }
}
