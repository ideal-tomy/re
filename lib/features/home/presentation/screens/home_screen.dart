import 'package:flutter/material.dart';
import 'package:re/core/theme.dart';
import 'package:re/features/character/data/models/character_model.dart';
import 'package:re/features/character/presentation/screens/character_select_screen.dart';

import 'package:re/features/chat/presentation/screens/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景：静寂な空間を演出するグラデーション
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E), // 深い紺
                  Color(0xFF16213E), // ダークブルー
                  Color(0xFF0F3460), // ネイビー
                ],
              ),
            ),
          ),
          
          // 静寂の肖像 (装飾的な円形グラデーション)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.primaryWhite.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      '知のサロン',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryWhite,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '時代を越えた、対話の入り口。',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.primaryWhite.withOpacity(0.6),
                        letterSpacing: 1.5,
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // 再会の兆し (センタービジュアル)
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white10, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.hourglass_empty_rounded,
                                size: 50,
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            '今はまだ、誰も訪れていません。',
                            style: TextStyle(color: Colors.white30, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // メニューセクション
                    _buildMenuCard(
                      context,
                      title: '偉人ライブラリ',
                      subtitle: '時代を拓いた50名の知者に会う',
                      icon: Icons.grid_view_rounded,
                      color: Colors.cyanAccent,
                      onTap: () async {
                        final selectedChar = await Navigator.push<Character>(
                          context,
                          MaterialPageRoute(builder: (context) => const CharacterSelectScreen()),
                        );
                        if (selectedChar != null) {
                          final index = dummyCharacters.indexOf(selectedChar);
                          if (index != -1) {
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatScreen(initialIndex: index)),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      context,
                      title: '会話の回想録',
                      subtitle: '魂の記録を振り返る（要ログイン）',
                      icon: Icons.history_rounded,
                      color: Colors.amberAccent,
                      onTap: () {}, // プレースホルダー
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallMenuCard(
                            context,
                            title: '自我の登録',
                            icon: Icons.person_add_rounded,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSmallMenuCard(
                            context,
                            title: '秘伝の書',
                            icon: Icons.auto_stories_rounded,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryWhite.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallMenuCard(BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white38, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
