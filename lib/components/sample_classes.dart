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
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 140, // Set the height of the story cards
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
      width: 90, // Set the width of each story card
      margin: EdgeInsets.all(12.0),
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

