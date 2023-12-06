import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackbarStatus {
  error(
    'warning',
    Color(0xffFFEEEE),
    Color(0xffD01414),
  ),
  warning(
    'warning',
    Color(0xffFFF6E4),
    Color(0xffF2B947),
  ),
  success(
    'success',
    Color(0xffE5F2F2),
    Color(0xff008069),
  );

  const SnackbarStatus(
    this.imageName,
    this.backgroundColor,
    this.iconColor,
  );

  final String imageName;
  final Color backgroundColor;
  final Color iconColor;
}

/// Controller of the API toast messages.
class CustomSnackbar {
  /// Method used to display the toast.
  static void showToast({
    required BuildContext context,
    required SnackbarStatus status,
    required String title,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: status.iconColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: status.backgroundColor,
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/${status.imageName}.png',
                width: 30,
                height: 30,
                color: status.iconColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: kToolbarHeight + 15),
      dismissType: DismissType.onSwipe,
      curve: Curves.easeOutCubic,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
