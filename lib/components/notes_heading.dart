import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  SectionHeader({
    required this.title,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                overflow: TextOverflow.fade,
                fontSize: 27,
                fontWeight: FontWeight.w800),
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            child: Text("See all"),
          ),
        ],
      ),
    );
  }
}
