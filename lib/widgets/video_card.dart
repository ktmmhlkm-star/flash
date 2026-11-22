import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/video_model.dart';
import 'action_buttons.dart';

class VideoCard extends StatefulWidget {
  final VideoModel video;
  final bool isActive;

  const VideoCard({super.key, required this.video, required this.isActive});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _showHeart = false;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            if (!mounted) return;
            setState(() {});
            _controller.setLooping(true);
            if (widget.isActive) _controller.play();
          });
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.play();
      _isPlaying = true;
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.pause();
      _isPlaying = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _heartController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _onDoubleTap() {
    setState(() => _showHeart = true);
    _heartController.forward(from: 0).then((_) {
      if (mounted) setState(() => _showHeart = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      onDoubleTap: _onDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const Center(
                child: CircularProgressIndicator(color: Colors.white)),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
          ),
          if (!_isPlaying && _controller.value.isInitialized)
            const Center(
              child: Icon(Icons.play_arrow, size: 90, color: Colors.white70),
            ),
          if (_showHeart)
            Center(
              child: ScaleTransition(
                scale: Tween(begin: 0.3, end: 1.4).animate(
                  CurvedAnimation(
                      parent: _heartController, curve: Curves.easeOut),
                ),
                child: FadeTransition(
                  opacity: Tween(begin: 1.0, end: 0.0).animate(
                    CurvedAnimation(
                      parent: _heartController,
                      curve: const Interval(0.5, 1.0),
                    ),
                  ),
                  child: const Icon(Icons.favorite,
                      color: Colors.white, size: 130),
                ),
              ),
            ),
          Positioned(
            right: 10,
            bottom: 110,
            child: ActionButtons(video: widget.video),
          ),
          Positioned(
            left: 14,
            right: 90,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '@${widget.video.username}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.video.caption,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.music_note,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.video.musicName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
