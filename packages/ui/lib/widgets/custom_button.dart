import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    // required this.width,
    required this.height,
    required this.title,
    this.loading = false,
    this.onPressed,
    super.key,
  });

  final void Function()? onPressed;
  // final double width;
  final double height;
  final String title;
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
        // width: width,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1111),
          borderRadius: BorderRadius.circular(34),
        ),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
      ),
    );
  }
}
