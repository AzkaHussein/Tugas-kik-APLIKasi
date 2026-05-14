import 'package:flutter/material.dart';
import '../main.dart';

class FeatureItem {
  final String label;
  final String assetPath;

  const FeatureItem({required this.label, required this.assetPath});
}

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  static const List<FeatureItem> features = [
    FeatureItem(label: 'Jemput Sampah', assetPath: 'assets/icons/ic_pickup.png'),
    FeatureItem(label: 'Taruh', assetPath: 'assets/icons/ic_drop.png'),
    FeatureItem(label: 'Artikel', assetPath: 'assets/icons/ic_article.png'),
    FeatureItem(label: 'Video Panduan', assetPath: 'assets/icons/ic_video.png'),
    FeatureItem(label: 'EcoMentor', assetPath: 'assets/icons/ic_mentor.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: features.map((f) => _buildFeatureItem(context, f)).toList(),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, FeatureItem item) {
    return GestureDetector(
      onTap: () {
        if (item.label == 'Artikel') {
          Navigator.of(context).pushNamed('/articles');
        } else if (item.label == 'Jemput Sampah') {
          Navigator.of(context).pushNamed('/pickup');
        } else if (item.label == 'Taruh') {
          Navigator.of(context).pushNamed('/taruh');
        } else if (item.label == 'Video Panduan') {
          Navigator.of(context).pushNamed('/video_tutorial');
        } else if (item.label == 'EcoMentor') {
          Navigator.of(context).pushNamed('/ecomentor');
        }
      },
      child: Column(

        children: [

          Container(

            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Image.asset(
                item.assetPath,
                width: 26,
                height: 26,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    _fallbackIcon(item.label),
                    size: 24,
                    color: AppTheme.primaryGreen,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 56,
            child: Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.textDark,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _fallbackIcon(String label) {
    if (label.contains('Jemput')) return Icons.local_shipping_outlined;
    if (label.contains('Taruh')) return Icons.place_outlined;
    if (label.contains('Artikel')) return Icons.article_outlined;
    if (label.contains('Video')) return Icons.play_circle_outline;
    if (label.contains('EcoMentor')) return Icons.school_outlined;
    return Icons.grid_view_rounded;
  }
}
