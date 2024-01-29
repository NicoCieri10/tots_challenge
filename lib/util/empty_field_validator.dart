import 'package:flutter/material.dart';
import 'package:tots_challenge/l10n/l10n.dart';

String? emptyFieldValidator({
  required BuildContext context,
  String? value,
}) {
  if (value == null || value.isEmpty) return context.l10n.fieldEmpty;

  return null;
}
