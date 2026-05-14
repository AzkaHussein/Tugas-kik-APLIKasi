import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key, this.size = 80});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE0E0E0),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          size: 40,
          color: Color(0xFF9E9E9E),
        ),
      ),
    );
  }
}

