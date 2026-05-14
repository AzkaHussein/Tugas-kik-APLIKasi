import 'package:flutter/material.dart';

import '../main.dart';
import '../services/dummy_database.dart';
import '../widgets/video_card.dart';

class VideoTutorialScreen extends StatelessWidget {
  const VideoTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = DummyDatabase();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: AppTheme.textDark,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Text(
                'Video Panduan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              centerTitle: false,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: db.videoTutorials.length,
                itemBuilder: (context, index) {
                  final item = db.videoTutorials[index];

                  final title = (item['title'] ?? '') as String;
                  final description = (item['description'] ?? '') as String;
                  final creator = (item['creator'] ?? '') as String;
                  final followers = (item['followers'] ?? '') as String;
                  final thumbnailUrl = item['thumbnailUrl'] as String?;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: VideoCard(
                      title: title,
                      description: description,
                      creator: creator,
                      followers: followers,
                      thumbnailUrl: thumbnailUrl,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Memutar video: $title'),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

