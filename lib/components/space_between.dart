import 'package:flutter/material.dart';

class SpaceBetween extends StatelessWidget {
  final double verticalPadding;
  final Color dividerColor;

  const SpaceBetween({super.key, 
    this.verticalPadding = 12.0,
    this.dividerColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Divider(
        height: 2,
        thickness: 1,
        color: dividerColor,
      ),
    );
  }
}
