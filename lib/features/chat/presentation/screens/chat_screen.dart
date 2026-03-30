import 'package:flutter/material.dart';
import 'package:re/core/theme.dart';
import 'package:re/features/character/data/models/character_model.dart';
import 'package:re/features/chat/presentation/widgets/character_view.dart';
import 'package:re/features/character/presentation/screens/character_select_screen.dart';
import 'package:re/features/chat/presentation/widgets/status_side_panel.dart';

class ChatScreen extends StatefulWidget {
  final int initialIndex;
  const ChatScreen({super.key, this.initialIndex = 0});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _isPanelOpen = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _openLibrary() async {
    final selectedChar = await Navigator.push<Character>(
      context,
      MaterialPageRoute(builder: (context) => const CharacterSelectScreen()),
    );
    if (selectedChar != null) {
      final index = dummyCharacters.indexOf(selectedChar);
      if (index != -1) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentChar = dummyCharacters[_currentIndex];

    return Scaffold(
      backgroundColor: AppTheme.primaryWhite,
      body: Stack(
        children: [
          // 1.0画面：メイン対話エリア
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: dummyCharacters.length,
            itemBuilder: (context, index) {
              final char = dummyCharacters[index];
              return CharacterView(char: char);
            },
          ),
          
          // ライブラリボタン（トップ左：以前のグリッドボタン）
          Positioned(
            top: 60,
            left: 20,
            child: Row(
              children: [
                FloatingActionButton.small(
                  heroTag: 'back_button',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: AppTheme.primaryWhite.withOpacity(0.9),
                  elevation: 4,
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textDark, size: 18),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  heroTag: 'library_button',
                  onPressed: _openLibrary,
                  backgroundColor: AppTheme.primaryWhite.withOpacity(0.9),
                  elevation: 4,
                  child: const Icon(Icons.grid_view_rounded, color: AppTheme.textDark),
                ),
              ],
            ),
          ),

          // 上部インジケーター
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryWhite.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: const Text(
                    "← スワイプで偉人を探索 →",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          // サイドパネル（右からスライド）
          StatusSidePanel(
            char: currentChar,
            isOpen: _isPanelOpen,
            onClose: () => setState(() => _isPanelOpen = false),
          ),

          // 握手アイコン（右下のフローティングボタン）
          Positioned(
            bottom: 40,
            right: 24,
            child: FloatingActionButton(
              onPressed: () => setState(() => _isPanelOpen = !_isPanelOpen),
              backgroundColor: AppTheme.primaryWhite,
              elevation: 8,
              child: Icon(
                _isPanelOpen ? Icons.close : Icons.handshake_rounded,
                color: currentChar.accent,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
