// ══════════════════════════════════════
// widgets/custom_text_field.dart
// ══════════════════════════════════════
import 'package:flutter/material.dart';
import '../main.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixAsset;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixAsset,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.textDark,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            prefixAsset,
            width: 20,
            height: 20,
            color: AppTheme.textGrey,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                _fallbackIcon(prefixAsset),
                color: AppTheme.textGrey,
                size: 20,
              );
            },
          ),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.borderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.borderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppTheme.primaryGreen, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  IconData _fallbackIcon(String asset) {
    if (asset.contains('email')) return Icons.email_outlined;
    if (asset.contains('password')) return Icons.lock_outline_rounded;
    if (asset.contains('person')) return Icons.person_outline_rounded;
    if (asset.contains('phone')) return Icons.phone_outlined;
    if (asset.contains('location')) return Icons.location_on_outlined;
    return Icons.info_outline;
  }
}
