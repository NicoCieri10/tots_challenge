import 'package:flutter/material.dart';
import 'package:tots_challenge/l10n/l10n.dart';

/// Validators for the app
class Validators {
  const Validators();

  /// Validates the email address
  static String? validateEmail({
    required BuildContext context,
    String? email,
  }) {
    final value = email?.trim();

    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (value == null || value.isEmpty) {
      return context.l10n.emailEmpty;
    }
    if (!emailRegExp.hasMatch(value)) {
      return context.l10n.emailInvalid;
    }
    return null;
  }

  /// Validates the password
  static String? validatePassword({
    required BuildContext context,
    String? password,
  }) {
    if (password == null || password.isEmpty) {
      return context.l10n.emptyPassword;
    }
    if (password.length < 8) {
      return context.l10n.passwordTooShort;
    }
    return null;
  }
}
