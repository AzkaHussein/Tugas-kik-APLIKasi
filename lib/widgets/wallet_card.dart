import 'package:flutter/material.dart';
import '../main.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Saldo EcoCash Kamu',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'EcoCash',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Balance
          const Text(
            'Rp. 19.000.000',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontFamily: 'Poppins',
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Earlene Zabrina',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white60,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 20),

          // Divider
          Container(height: 1, color: Colors.white12),
          const SizedBox(height: 16),

          // Action buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWalletAction('assets/icons/ic_receive.png', 'Terima Saldo'),
              _buildWalletAction('assets/icons/ic_history.png', 'Histori'),
              _buildWalletAction('assets/icons/ic_saved.png', 'Disimpan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletAction(String assetPath, String label) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              assetPath,
              width: 22,
              height: 22,
              color: Colors.white,
              errorBuilder: (context, error, stackTrace) {
                IconData icon = Icons.monetization_on_outlined;
                if (assetPath.contains('history')) icon = Icons.history;
                if (assetPath.contains('saved')) icon = Icons.bookmark_outline;
                return Icon(icon, color: Colors.white, size: 22);
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
