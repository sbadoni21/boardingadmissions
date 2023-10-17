import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';

class VideoPlayerWithControls extends StatefulWidget {
  @override
  _VideoPlayerWithControlsState createState() =>
      _VideoPlayerWithControlsState();
}

class _VideoPlayerWithControlsState extends State<VideoPlayerWithControls> {
  late VideoPlayerController _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _volume = 0.5;
  double _sliderValue = 0.0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('videos/video.mp4');
    _videoController.initialize().then((_) {
      setState(() {});
    });

    _audioPlayer.setVolume(_volume);

    _audioPlayer.volumeStream.listen((event) {
      setState(() {
        _volume = event;
      });
    });

    _videoController.addListener(() {
      setState(() {
        _sliderValue =
            _videoController.value.position.inMilliseconds.toDouble();
      });
    });
  }

  void skip(int seconds) {
    final newPosition = _videoController.value.position + Duration(seconds: seconds);
    if (newPosition < _videoController.value.duration) {
      _videoController.seekTo(newPosition);
    }
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _videoController.pause();
      _audioPlayer.pause();
    } else {
      _videoController.play();
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(_videoController),
          ),
          Slider(
            value: _sliderValue,
            min: 0,
            max: _videoController.value.duration.inMilliseconds.toDouble(),
            onChanged: (value) {
              _videoController.seekTo(Duration(milliseconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {
                  skip(-10);
                },
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: togglePlayPause,
              ),
              IconButton(
                icon: Icon(Icons.forward_10),
                onPressed: () {
                  skip(10);
                },
              ),
              Slider(
                value: _volume,
                min: 0.0,
                max: 1.0,
                onChanged: (value) {
                  setState(() {
                    _volume = value;
                    _audioPlayer.setVolume(value);
                  });
                },
              ),
              // Add quality selection here
              // Example: DropdownButton<String>(...),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
