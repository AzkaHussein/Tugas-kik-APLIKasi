import 'package:flutter/material.dart';
import '../services/dummy_database.dart';
import '../widgets/profile_photo.dart';
import '../widgets/level_badge.dart';
import '../widgets/stat_card.dart';
import '../widgets/achievement_item.dart';
import '../widgets/bottom_nav_bar.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DummyDatabase _db = DummyDatabase();

  @override
  void initState() {
    super.initState();
    // _db.refreshData();
  }


  @override
  Widget build(BuildContext context) {
    final name = _db.userProfile['name'] ?? '';
    final address = _db.userProfile['address'] ?? '';
    final level = _db.userProfile['level'] ?? '';

    final income = _db.stats['income'] as int;
    final totalDrop = _db.stats['totalDrop'] as int;
    final totalPickup = _db.stats['totalPickup'] as int;

    final incomeFormatted = _db.formatRupiah(income);

    final bottomNav = BottomNavBar(
      currentIndex: 3,
      onTap: (index) {
        if (index == 3) return;
        if (index == 0) {
          Navigator.of(context).pushNamed('/home');
        } else if (index == 1) {
          Navigator.of(context).pushNamed('/history');
        }
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(child: ProfilePhoto(size: 80)),
                const SizedBox(height: 12),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                Center(child: LevelBadge(level: level)),
                const SizedBox(height: 16),

                // Stats cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: StatCard(
                            value: incomeFormatted,
                            label: 'Pemasukan',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: StatCard(
                            value: totalDrop.toString(),
                            unit: 'kg',
                            label: 'Total Taruh',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: StatCard(
                            value: totalPickup.toString(),
                            unit: 'kg',
                            label: 'Total Jemput',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Achievements
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lahap Semua',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: _db.achievements
                        .map(
                          (e) => AchievementItem(
                            title: e['title'] as String,
                            date: e['date'] as String,
                            achieved: e['achieved'] as bool,
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 12,
            child: ClipOval(
              child: Material(
                color: Colors.white.withOpacity(0.9),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom nav always visible (tanpa Positioned)
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNav,
          ),
        ],
      ),
    );
  }
}

