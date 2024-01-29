import 'package:flutter/material.dart';
import 'package:tots_challenge/l10n/l10n.dart';

String? validateEmail({
  required BuildContext context,
  String? email,
}) {
  final value = email?.trim();

  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  if (value == null || value.isEmpty) return context.l10n.emailEmpty;

  if (!emailRegExp.hasMatch(value)) return context.l10n.emailInvalid;

  return null;
}
