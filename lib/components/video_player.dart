import 'dart:async';

import 'package:boardingadmissions/components/appbar.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class Comment {
  final String userName;
  final String text;
  final DateTime timestamp;

  Comment(this.userName, this.text, this.timestamp);
}

List comments = [];

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isBookmarked = false;
  bool isVolumeSliderVisible = false;

  Timer? _positionUpdateTimer;
  TextEditingController commentController = TextEditingController();
  var _initializeVideoPlayerFuture;
  final List<String> videoUrls = [
    'assets/videos/cat.mp4',
    'assets/videos/sigma.mp4',
    'assets/videos/sigma.mp4',
    'assets/videos/cat.mp4',
    'assets/videos/cat.mp4',
    'assets/videos/cat.mp4',
    // Add more video URLs as needed
  ];
  bool isExpanded = false;
  int currentVideoIndex = 0;

  String _formatDuration(Duration duration) {
    // Format the duration as 'mm:ss'
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoUrls[1]);

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});

      _positionUpdateTimer =
          Timer.periodic(Duration(milliseconds: 500), (timer) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  void _loadNextVideo() {
    if (currentVideoIndex < videoUrls.length - 1) {
      currentVideoIndex++;
      final nextVideoUrl = videoUrls[currentVideoIndex];
      _controller = VideoPlayerController.asset(nextVideoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.play();
      setState(() {});
    }
  }

  void _loadPreviousVideo() {
    if (currentVideoIndex != 0) {
      currentVideoIndex--;
      final nextVideoUrl = videoUrls[currentVideoIndex];
      _controller = VideoPlayerController.asset(nextVideoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.play();
      setState(() {});
    }
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionUpdateTimer?.cancel();
    _controller.dispose();
  }

  double sliderValue = 0.0; // Declare a variable to control the slider value

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          children: [
            FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${_formatDuration(_controller.value.position)}", // Format the duration for display
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${_formatDuration(_controller.value.duration)}", // Format the duration for display
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Slider(
              value: _controller.value.position.inSeconds.toDouble(),
              onChanged: (double value) {
                final Duration newPosition = Duration(seconds: value.toInt());
                setState(() {
                  _controller.seekTo(newPosition);
                });
              },
              min: 0,
              max: _controller.value.duration.inSeconds.toDouble(),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Voluem button to be visible for tabs and windows
                  // IconButton(
                  //   icon: Icon(Icons.volume_up),
                  //   onPressed: () {
                  //     setState(() {
                  //       isVolumeSliderVisible =
                  //           !isVolumeSliderVisible; // Toggle visibility
                  //     });
                  //   },
                  // ),
                  // Visibility(
                  //   visible: isVolumeSliderVisible,
                  //   child: Expanded(
                  //     child: Slider(
                  //       value: _volume,
                  //       onChanged: (double value) {
                  //         setState(() {
                  //           _volume = value;
                  //           _controller.setVolume(_volume);
                  //         });
                  //       },
                  //       min: 0.0,
                  //       max: 1.0,
                  //     ),
                  //   ),
                  // ),

                  IconButton(
                    onPressed: () {
                      setState(() {
                        final newPosition =
                            _controller.value.position - Duration(seconds: 10);
                        _controller.seekTo(newPosition);
                      });
                    },
                    icon: Icon(Icons.replay_10_rounded),
                  ),
                  TextButton(
                    onPressed: () {
                      _loadPreviousVideo();
                    },
                    child: Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.stop
                        : Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {
                      _loadNextVideo();
                    },
                    icon: Icon(Icons.skip_next),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        final newPosition =
                            _controller.value.position + Duration(seconds: 10);
                        _controller.seekTo(newPosition);
                      });
                    },
                    icon: Icon(Icons.forward_10_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isBookmarked = !_isBookmarked;
                      });
                    },
                    icon: Icon(Icons.bookmark,
                        color: _isBookmarked ? Colors.blue : Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: _toggleExpansion,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: isExpanded
                      ? 150.0
                      : 60.0, // Adjust the initial and expanded heights

                  child: isExpanded
                      ? Container(
                          color: Colors.amber,
                          // width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Line 1'),
                              Text('Line 2'),
                              Text('Line 3'),
                              Text('Line 1'),
                              Text('Line 2'),
                              Text('Line 3'),
                            ],
                          ),
                        )
                      : Container(
                          // width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Line 1'),
                              Text('Line 2'),
                              Text('Line 3'),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Row(
                children: [
                  Text(
                    "Comments",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add a public comment...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final newComment =
                          Comment('User', commentController.text, DateTime.now());
                      setState(() {
                        comments.add(newComment);
                      });
                      commentController.clear();
                    },
                    
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: 250,
              height: 300,
              child: ListView.builder(
                itemCount:
                    comments.length, // Replace with your list of comments
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    leading: Icon(Icons
                        .account_circle), // You can replace this with a user's profile picture
                    title: Text(comment.userName),
                    subtitle: Text(comment.text),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
