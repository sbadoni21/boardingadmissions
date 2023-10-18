import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';


class HoverImageEffect extends StatefulWidget {
  @override
  _HoverImageEffectState createState() => _HoverImageEffectState();
}

class _HoverImageEffectState extends State<HoverImageEffect> {
  bool _isHovered = false;

  void _onEnter(PointerEvent event) {
    setState(() {
      _isHovered = true;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Stack(
        children: <Widget>[
          MouseRegion(
            onEnter: _onEnter,
            onExit: _onExit,
            child: Image.asset(
              'assets/image1.png', // Replace with your background image asset path
              width: 100,
              height: 100,
            ),
          ),
          if (_isHovered)
            Image.asset(
              'assets/school1.png', // Replace with your overlay image asset path
              width: 50,
              height: 50,
            ),
        ],
      ),
      decoration: BoxDecoration(
        border: _isHovered
            ? Border.all(color: Colors.red, width: 2.0) // Add border on hover
            : null,
      ),
    );
  }
}
