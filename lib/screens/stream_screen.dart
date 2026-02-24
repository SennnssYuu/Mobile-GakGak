import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  void _playRandomVideo() async {
    final random = Random();
    final randomNumber = random.nextInt(3) + 1; // 1-3

    final videoPath = "assets/Video/v$randomNumber.mp4";

    _controller?.dispose();

    _controller = VideoPlayerController.asset(videoPath);

    await _controller!.initialize();

    print(_controller!.value.size);
    print(_controller!.value.aspectRatio);

    setState(() {
      _controller!.play();
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
        children: [
          // 🎥 Video Player
          Positioned.fill(
            child: _controller != null &&
                    _controller!.value.isInitialized
                ? SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  )
                : Container(color: Colors.black),
          ),
          // 🔳 Overlay (only when not playing)
          if (!_isPlaying)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),

          // ▶ Play Button (only when not playing)
          if (!_isPlaying)
            Center(
              child: GestureDetector(
                onTap: _playRandomVideo,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),

          // ⬅ Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}