import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

class VideoPlayerWithControls extends StatefulWidget {
  @override
  _VideoPlayerWithControlsState createState() => _VideoPlayerWithControlsState();
}

class VideoData {
  final String videoAsset;
  final String thumbnailAsset;
  final String title;

  VideoData({
    required this.videoAsset,
    required this.thumbnailAsset,
    required this.title,
  });
}

class _VideoPlayerWithControlsState extends State<VideoPlayerWithControls> {
  late VideoPlayerController _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _volume = 0.5;
  double _sliderValue = 0.0;
  bool _isPlaying = false;
  bool _hovering = false;
  bool _controlsVisible = false;

  int _currentVideoIndex = 0;
  Timer? _hoverDebounceTimer;

  List<VideoData> videoDataList = [
    VideoData(
      videoAsset: 'videos/video.mp4',
      thumbnailAsset: 'assets/image1.png',
      title: 'Video 1',
    ),
    VideoData(
      videoAsset: 'videos/video.mp4',
      thumbnailAsset: 'assets/image1.png',
      title: 'Video 2',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(videoDataList[_currentVideoIndex]);
  }

  void _initializeVideoPlayer(VideoData videoData) {
    _videoController = VideoPlayerController.asset(videoData.videoAsset)
      ..initialize().then((_) {
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
        _sliderValue = _videoController.value.position.inMilliseconds.toDouble();
      });
    });
  }

  void _showControls() {
    if (!_controlsVisible) {
      setState(() {
        _controlsVisible = true;
      });
    }
  }

  void _hideControls() {
    Future.delayed(Duration(seconds: 2), () {
      if (!_hovering) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  void _changeVideo(int index) {
    if (index >= 0 && index < videoDataList.length) {
      _videoController.pause();
      _audioPlayer.pause();
      _videoController.dispose();
      _initializeVideoPlayer(videoDataList[index]);
      setState(() {
        _currentVideoIndex = index;
        _isPlaying = false;
      });
    }
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

  void seekTo(double value) {
    final position = (value / 100) * _videoController.value.duration.inMilliseconds;
    _videoController.seekTo(Duration(milliseconds: position.toInt()));
  }

  void debounceHoverState(bool isHovered) {
    _hoverDebounceTimer?.cancel();
    _hoverDebounceTimer = Timer(Duration(milliseconds: 300), () {
      setState(() {
        _hovering = isHovered;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          if (_controlsVisible) {
            _hideControls();
          } else {
            _showControls();
          }
        },
        child: Column(
          children: <Widget>[
            MouseRegion(
              onEnter: (_) {
                debounceHoverState(true);
              },
              onExit: (_) {
                debounceHoverState(false);
                _hideControls();
              },
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(_videoController),
              ),
            ),
 
              Slider(
                value: _sliderValue,
                min: 0,
                max: _videoController.value.duration.inMilliseconds.toDouble(),
                onChanged: (value) {
                  seekTo(value);
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
            Text(
              formatDuration(_videoController.value.duration),
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
              ),
            ),
            Text(
              formatDuration(_videoController.value.position),
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${duration.inHours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer.dispose();

    super.dispose();
  }
}
