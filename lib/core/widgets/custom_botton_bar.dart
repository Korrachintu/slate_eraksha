import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;

  const CustomBottomBar({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    this.borderRadius = 32,
    this.elevation = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 14),
        child: Material(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: elevation,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
