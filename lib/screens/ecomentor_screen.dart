import 'package:flutter/material.dart';

import '../main.dart';
import '../services/dummy_database.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/date_separator.dart';

class EcoMentorScreen extends StatefulWidget {
  const EcoMentorScreen({super.key});

  @override
  State<EcoMentorScreen> createState() => _EcoMentorScreenState();
}

class _EcoMentorScreenState extends State<EcoMentorScreen> {
  final DummyDatabase _db = DummyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: ClipOval(
          child: Material(
            color: Colors.white.withOpacity(0.9),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'EcoMentor',
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                itemCount: _buildChatItems().length,
                itemBuilder: (context, index) {
                  final item = _buildChatItems()[index];
                  if (item['type'] == 'separator') {
                    return DateSeparator(date: item['date'] as String);
                  }

                  final msg = item['message'] as Map<String, dynamic>;
                  final sender = msg['sender'] as String? ?? 'mentor';
                  final isUser = sender == 'user';

                  return ChatBubble(
                    message: (msg['message'] ?? '') as String,
                    time: (msg['time'] ?? '') as String,
                    isUser: isUser,
                  );
                },
              ),
            ),
            _buildComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Tulis pesan...',
                    hintStyle: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) {},
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // dummy send action
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // dummy mic action
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.mic_none_rounded,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildChatItems() {
    final items = <Map<String, dynamic>>[];

    String? lastDate;
    for (final msg in _db.chatMessages) {
      final dateGroup = msg['dateGroup'] as String? ?? '';
      if (dateGroup.isNotEmpty && dateGroup != lastDate) {
        items.add({'type': 'separator', 'date': dateGroup});
        lastDate = dateGroup;
      }

      items.add({'type': 'message', 'message': msg});
    }

    return items;
  }
}


