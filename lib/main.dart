import 'package:flutter/material.dart';
import 'data/sample_videos.dart';
import 'widgets/video_card.dart';

void main() => runApp(const FlashApp());

class FlashApp extends StatelessWidget {
  const FlashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC107),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sampleVideos.length,
        onPageChanged: (i) => setState(() => _currentPage = i),
        itemBuilder: (_, i) => VideoCard(
          video: sampleVideos[i],
          isActive: i == _currentPage,
        ),
      ),
      const Center(
        child: Text('Discover',
            style: TextStyle(color: Colors.white70, fontSize: 22)),
      ),
      const Center(
        child: Text('Inbox',
            style: TextStyle(color: Colors.white70, fontSize: 22)),
      ),
      const Center(
        child: Text('Profile',
            style: TextStyle(color: Colors.white70, fontSize: 22)),
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(bottom: 6),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          currentIndex: _index,
          selectedItemColor: const Color(0xFFFFC107),
          unselectedItemColor: Colors.grey,
          onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Discover'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Inbox'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
