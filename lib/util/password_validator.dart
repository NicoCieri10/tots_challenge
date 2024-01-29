import 'package:flutter/material.dart';
import 'package:tots_challenge/l10n/l10n.dart';

String? validatePassword({
  required BuildContext context,
  String? password,
}) {
  if (password == null || password.isEmpty) return context.l10n.emptyPassword;

  if (password.length < 8) return context.l10n.passwordTooShort;

  return null;
}
