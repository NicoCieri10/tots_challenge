import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/widgets.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({
    required this.elements,
    required this.child,
    super.key,
  });

  final List<BackgroundElement> elements;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Blur(
          blur: 40,
          blurColor: Colors.white.withOpacity(0.5),
          colorOpacity: 0.05,
          child: Stack(
            children: [...elements],
          ),
        ),
        child,
      ],
    );
  }
}
