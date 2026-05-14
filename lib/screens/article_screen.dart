import 'package:flutter/material.dart';

import '../main.dart';
import '../services/dummy_database.dart';
import '../widgets/article_featured_card.dart';
import '../widgets/recommend_account_item.dart';
import '../widgets/bottom_nav_bar.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final DummyDatabase _db = DummyDatabase();

  int _getCurrentIndexForBottomNav() => 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    'Artikel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Header / Collection
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Artikel',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1A1A1A),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Artikel koleksi, Produk, atau Toko',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF757575),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Featured card / Artikel Lainnya (first)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              'Artikel Lainnya',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ArticleFeaturedCard(
                              title: _db.featuredArticle['title'] ?? '',
                              subtitle: _db.featuredArticle['subtitle'] ?? '',
                              imageUrl: _db.featuredArticle['imageUrl'],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // List recommended accounts (second)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              'Artikel Lainnya',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          ListView.builder(
                            itemCount: _db.recommendAccounts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 0),
                            itemBuilder: (context, index) {
                              final e = _db.recommendAccounts[index];
                              return RecommendAccountItem(
                                name: (e['name'] ?? '') as String,
                                followers: (e['followers'] ?? '') as String,
                                avatarUrl: e['avatarUrl'] as String?,
                              );
                            },
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
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

