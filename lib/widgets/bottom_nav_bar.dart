import 'package:flutter/material.dart';
import '../main.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavItem> items = [
    _NavItem(label: 'Home', assetActive: 'assets/icons/nav_home_active.png', assetInactive: 'assets/icons/nav_home.png'),
    _NavItem(label: 'Riwayat', assetActive: 'assets/icons/nav_history_active.png', assetInactive: 'assets/icons/nav_history.png'),
    _NavItem(label: 'Keranjang', assetActive: 'assets/icons/nav_cart_active.png', assetInactive: 'assets/icons/nav_cart.png'),
    _NavItem(label: 'Profil', assetActive: 'assets/icons/nav_profile_active.png', assetInactive: 'assets/icons/nav_profile.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length, (index) {
            final isActive = index == currentIndex;
            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 70,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isActive
                            ? AppTheme.primaryGreen
                            : AppTheme.textLightGrey,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        isActive
                            ? items[index].assetActive
                            : items[index].assetInactive,
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _fallbackIcon(index),
                            size: 24,
                            color: isActive
                                ? AppTheme.primaryGreen
                                : AppTheme.textLightGrey,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isActive
                            ? AppTheme.primaryGreen
                            : AppTheme.textLightGrey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  IconData _fallbackIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.history_rounded;
      case 2:
        return Icons.shopping_cart_outlined;
      case 3:
        return Icons.person_outline_rounded;
      default:
        return Icons.circle;
    }
  }
}

class _NavItem {
  final String label;
  final String assetActive;
  final String assetInactive;

  const _NavItem({
    required this.label,
    required this.assetActive,
    required this.assetInactive,
  });
}
