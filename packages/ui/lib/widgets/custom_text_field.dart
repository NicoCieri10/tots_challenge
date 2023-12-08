import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    this.hintText,
    this.obscureText,
    this.onPressed,
    this.validator,
    this.keyboardType,
    this.autofillHints,
    this.onFieldSubmitted,
    this.focusNode,
    super.key,
  });

  final bool? obscureText;
  final String? hintText;
  final void Function()? onPressed;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: const Color(0xff161B14),
        fontSize: 12.sp,
      ),
      suffixIcon: obscureText != null
          ? IconButton(
              onPressed: onPressed,
              icon: Icon(
                obscureText! ? Icons.visibility : Icons.visibility_off_outlined,
                color: const Color(0xffA7A8A9),
              ),
            )
          : null,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xff0D1111).withOpacity(0.85),
        ),
      ),
    );
    return TextFormField(
      decoration: decoration,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
    );
  }
}
