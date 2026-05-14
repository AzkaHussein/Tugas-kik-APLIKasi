import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  const AchievementItem({
    super.key,
    required this.title,
    required this.date,
    required this.achieved,
  });

  final String title;
  final String date;
  final bool achieved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.emoji_events,
              color: const Color(0xFFFFC107),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              achieved ? Icons.check_circle : Icons.radio_button_unchecked,
              color: achieved ? const Color(0xFF4CAF50) : const Color(0xFFBDBDBD),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

