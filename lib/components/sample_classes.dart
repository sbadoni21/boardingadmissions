import 'package:boardingadmissions/components/video_player.dart';
import 'package:flutter/material.dart';


class SampleClasses extends StatelessWidget {
  final List<Map<String, dynamic>> buttonTitles = [
    {"title": "Story 1", "videoPlayer": VideoPlayerScreen()},
    {"title": "Story 2", "videoPlayer": VideoPlayerScreen()},
    {"title": "Story 3", "videoPlayer": VideoPlayerScreen()},
    {"title": "Story 4", "videoPlayer": VideoPlayerScreen()},
    {"title": "Story 5", "videoPlayer": VideoPlayerScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      height: 160, // Set the height of the story cards
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buttonTitles
            .map((item) => buildStoryCard(context, item['title'], item['videoPlayer']))
            .toList(),
      ),
    );
  }

  Widget buildStoryCard(BuildContext context, String title, Widget route) {
    return Container(
      width: 120, // Set the width of each story card
      margin: EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle button click, e.g., navigate to the video player screen.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
