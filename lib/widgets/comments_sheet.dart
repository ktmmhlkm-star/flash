import 'package:flutter/material.dart';

void showCommentsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      final comments = List.generate(15, (i) {
        return {
          'user': 'user_$i',
          'text': 'تعليق رقم $i — الفيديو ده رهيب 🔥',
          'likes': (i + 1) * 12,
        };
      });
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text('تعليقات',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (_, i) {
                  final c = comments[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://pravatar.cc{(i + 5) % 70}'),
                    ),
                    title: Text('@${c['user']}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13)),
                    subtitle: Text(c['text'] as String,
                        style: const TextStyle(color: Colors.white)),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite_border,
                            color: Colors.white54, size: 18),
                        Text('${c['likes']}',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'أضف تعليقاً...',
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFFFC107)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
