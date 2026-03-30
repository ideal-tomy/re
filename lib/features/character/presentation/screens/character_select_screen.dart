import 'package:flutter/material.dart';
import 'package:re/features/character/data/models/character_model.dart';
import 'package:re/core/theme.dart';

class CharacterSelectScreen extends StatelessWidget {
  const CharacterSelectScreen({super.key});

  static const List<String> categories = [
    '日本の文豪',
    '日本の武将・英雄',
    '哲学系',
    '世界の文豪',
    '世界の統治者',
    '思想家',
    '画家・彫刻家',
    '科学・発明',
    '音楽家',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryWhite,
      appBar: AppBar(
        title: const Text('偉人ライブラリ', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final charactersInCategory = dummyCharacters.where((c) => c.category == category).toList();

          return Column(
            children: [
              _buildCategoryFolder(context, category, charactersInCategory),
              const Divider(height: 1, indent: 56),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryFolder(BuildContext context, String title, List<Character> characters) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: const Icon(Icons.folder, color: Colors.grey, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppTheme.textDark,
          ),
        ),
        trailing: Text(
          '${characters.length}',
          style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold),
        ),
        children: characters.isEmpty
            ? [
                const ListTile(
                  title: Text('準備中...', style: TextStyle(color: Colors.grey, fontSize: 14)),
                )
              ]
            : characters.map((char) => ListTile(
                  contentPadding: const EdgeInsets.only(left: 72, right: 16),
                  leading: Text(char.image, style: const TextStyle(fontSize: 24)),
                  title: Text(char.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(char.title, style: const TextStyle(fontSize: 12)),
                  onTap: () {
                    Navigator.pop(context, char);
                  },
                )).toList(),
      ),
    );
  }
}
