import 'package:flutter/material.dart';
import '../models/video_model.dart';
import 'comments_sheet.dart';

class ActionButtons extends StatefulWidget {
  final VideoModel video;
  const ActionButtons({super.key, required this.video});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool _liked = false;
  int _likes = 0;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _likes = widget.video.likes;
  }

  void _toggleLike() {
    setState(() {
      _liked = !_liked;
      _likes += _liked ? 1 : -1;
    });
  }

  String _format(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(widget.video.avatarUrl),
        ),
        const SizedBox(height: 22),
        _iconButton(
          icon: _liked ? Icons.favorite : Icons.favorite_border,
          color: _liked ? const Color(0xFFFFC107) : Colors.white,
          label: _format(_likes),
          onTap: _toggleLike,
        ),
        const SizedBox(height: 18),
        _iconButton(
          icon: Icons.mode_comment,
          label: _format(widget.video.comments),
          onTap: () => showCommentsSheet(context),
        ),
        const SizedBox(height: 18),
        _iconButton(
          icon: Icons.share,
          label: _format(widget.video.shares),
          onTap: () {},
        ),
        const SizedBox(height: 18),
        _iconButton(
          icon: _saved ? Icons.bookmark : Icons.bookmark_border,
          label: 'Save',
          onTap: () => setState(() => _saved = !_saved),
        ),
        const SizedBox(height: 20),
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Colors.black, Colors.grey]),
          ),
          child: const Icon(Icons.music_note,
              color: Colors.white, size: 20),
        ),
      ],
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 34),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
