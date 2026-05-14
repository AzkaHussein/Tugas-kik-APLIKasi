import 'package:flutter/material.dart';

import '../main.dart';
import '../services/dummy_database.dart';
import '../widgets/pickup_order_card.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final DummyDatabase _db = DummyDatabase();

  @override
  Widget build(BuildContext context) {
    final orders = _db.pickupOrders;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: ClipOval(
          child: Material(
            color: Colors.white.withOpacity(0.9),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Center(
                  child: Icon(Icons.arrow_back, size: 20, color: Color(0xFF1A1A1A)),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Jemput Sampah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: orders.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada pesanan.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final e = orders[index];
                  return PickupOrderCard(
                    name: (e['name'] ?? '') as String,
                    caption: (e['caption'] ?? '') as String,
                    amount: (e['amount'] ?? '') as String,
                    avatarUrl: e['avatarUrl'] as String?,
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Ambil pesanan ini?',
                              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                            ),
                            content: const Text(
                              'Pesanan akan dipindahkan ke status diambil.',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text(
                                  'Batal',
                                  style: TextStyle(fontFamily: 'Poppins', color: AppTheme.textGrey),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryGreen,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Ambil',
                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmed == true) {
                        setState(() {
                          _db.takeOrder(index);
                        });
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pesanan diambil',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}

