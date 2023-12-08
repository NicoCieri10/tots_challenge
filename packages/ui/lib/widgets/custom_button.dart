import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.height,
    required this.child,
    this.loading = false,
    this.onPressed,
    super.key,
  });

  final void Function()? onPressed;
  final double height;
  final Widget child;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1111),
          borderRadius: BorderRadius.circular(34),
        ),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : child,
      ),
    );
  }
}
