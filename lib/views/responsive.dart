import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return mobile;
    } else if (width < 1200) {
      return tablet;
    } else {
      return desktop;
    }
  }
}

class MobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Mobile View'),
    );
  }
}

class TabletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tablet View'),
    );
  }
}

class DesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Desktop View'),
    );
  }
}
