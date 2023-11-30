import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundElement extends StatelessWidget {
  const BackgroundElement({
    required this.svg,
    required this.alignment,
    super.key,
  });

  final String svg;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: MediaQuery.of(context).size.height,
      alignment: alignment,
      child: SvgPicture.asset(
        svg,
        colorFilter: const ColorFilter.mode(
          Color(0xFFE4F354),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
