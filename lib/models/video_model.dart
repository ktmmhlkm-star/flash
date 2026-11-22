class VideoModel {
  final String id;
  final String username;
  final String caption;
  final String videoUrl;
  final String musicName;
  final int likes;
  final int comments;
  final int shares;
  final String avatarUrl;

  VideoModel({
    required this.id,
    required this.username,
    required this.caption,
    required this.videoUrl,
    required this.musicName,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.avatarUrl,
  });
}
