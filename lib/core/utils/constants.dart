import 'app_colors.dart';
import 'app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static void showErrorDialog({
    required BuildContext context,
    required String msg,
  }) =>
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            msg,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(AppStrings.ok),
            ),
          ],
        ),
      );

  static void showSankBar({
    required String msg,
    Color? backgroundColor,
    required BuildContext context,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
}
