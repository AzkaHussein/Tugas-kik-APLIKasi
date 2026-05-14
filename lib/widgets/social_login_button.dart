import 'package:flutter/material.dart';
import '../main.dart';

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 26,
            height: 26,
            errorBuilder: (context, error, stackTrace) {
              IconData icon = Icons.login;
              if (assetPath.contains('google')) icon = Icons.g_mobiledata;
              if (assetPath.contains('apple')) icon = Icons.apple;
              if (assetPath.contains('phone')) icon = Icons.phone_outlined;
              return Icon(icon, size: 26, color: AppTheme.textDark);
            },
          ),
        ),
      ),
    );
  }
}
