import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  const Responsive(
      {super.key, required this.mobile, this.tablet, this.desktop});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1900;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1900) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= 768) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

extension ResponsiveSpacing on BuildContext {
  double get spacing => Responsive.isTablet(this) ? 16.0 : 12.0;
  double get radius => Responsive.isTablet(this) ? 16.0 : 12.0;
  double get fontSize => Responsive.isTablet(this) ? 16.0 : 14.0;
  double get iconSize => Responsive.isTablet(this) ? 24.0 : 20.0;
}