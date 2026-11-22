import '../models/video_model.dart';

final List<VideoModel> sampleVideos = [
  VideoModel(
    id: '1',
    username: 'ahmed_dev',
    caption: 'أول فيديو تجريبي 🎥 #flash',
    videoUrl: 'https:/flutter./github.io' +
        '/assets-for-api-docs/assets/videos/bee.mp4',
    musicName: 'Original Sound - ahmed_dev',
    likes: 12500,
    comments: 340,
    shares: 89,
    avatarUrl: 'https://picsum.photos' + '/id/64/150/150',
  ),
  VideoModel(
    id: '2',
    username: 'sara_travel',
    caption: 'رحلة إلى الطبيعة 🦋',
    videoUrl: 'https:/flutter./github.io' +
        '/assets-for-api-docs/assets/videos/butterfly.mp4',
    musicName: 'Adventure - Sound Track',
    likes: 87300,
    comments: 1200,
    shares: 540,
    avatarUrl: 'https://picsum.photos' + '/id/65/150/150',
  ),
];
