import 'package:flutter/material.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';

class CardLayout extends StatelessWidget {
  const CardLayout(
      {super.key, this.color, required this.child, this.minHeight});

  final Color? color;
  final Widget child;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.dynamicWidth(0.04),
      ),
      constraints: BoxConstraints(
        minHeight: minHeight ?? context.dynamicHeight(0.25),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidth(0.04),
        vertical: context.dynamicHeight(0.02),
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
