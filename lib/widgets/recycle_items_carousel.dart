import 'package:flutter/material.dart';
import '../main.dart';

class RecycleItem {
  final String name;
  final String price;
  final String assetPath;

  const RecycleItem({
    required this.name,
    required this.price,
    required this.assetPath,
  });
}

class RecycleItemsCarousel extends StatelessWidget {
  const RecycleItemsCarousel({super.key});

  static const List<RecycleItem> items = [
    RecycleItem(name: 'Bioplastic', price: 'Rp.2000', assetPath: 'assets/images/bioplastic.png'),
    RecycleItem(name: 'Biomass', price: 'Rp.2000', assetPath: 'assets/images/biomass.png'),
    RecycleItem(name: 'Biobattery', price: 'Rp.2000', assetPath: 'assets/images/biobattery.png'),
    RecycleItem(name: 'Biogas', price: 'Rp.2000', assetPath: 'assets/images/biogas.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildItemCard(items[index]);
        },
      ),
    );
  }

  Widget _buildItemCard(RecycleItem item) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: Image.asset(
              item.assetPath,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 90,
                  color: const Color(0xFFE8F5E9),
                  child: Center(
                    child: Icon(
                      Icons.eco_rounded,
                      size: 40,
                      color: AppTheme.primaryGreen.withOpacity(0.6),
                    ),
                  ),
                );
              },
            ),
          ),

          // Item info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.price,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
