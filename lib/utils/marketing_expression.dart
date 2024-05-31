import 'package:flutter/material.dart';

class MarketingExpression extends StatelessWidget {
  const MarketingExpression(
      {super.key,
      required this.visible,
      required this.child,
      this.left,
      this.top,
      this.right,
      this.bottom,
      required this.borderRadius});

  final bool visible;
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Positioned(
          left: left,
          right: right,
          top: top,
          bottom: bottom,
          child: ClipRRect(
            borderRadius: borderRadius,
              child: child)),
    );
  }
}
