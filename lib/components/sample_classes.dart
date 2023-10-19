import 'package:flutter/material.dart';

class SampleClasses extends StatelessWidget {
  final List<String> buttonTitles = [
    "Story 1",
    "Story 2",
    "Story 3",
    "Story 4",
    "Story 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      height: 160, // Set the height of the story cards
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (String title in buttonTitles) buildStoryCard(title),
        ],
      ),
    );
  }

  Widget buildStoryCard(String title) {
    return Container(
      width: 120, // Set the width of each story card
      margin: EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
