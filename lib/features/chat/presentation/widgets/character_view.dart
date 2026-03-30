import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:re/features/character/data/models/character_model.dart';
import 'package:re/core/theme.dart';
import 'package:re/features/chat/presentation/providers/chat_provider.dart';
import 'package:re/features/chat/data/demo_responses.dart';

class CharacterView extends ConsumerStatefulWidget {
  final Character char;
  const CharacterView({super.key, required this.char});

  @override
  ConsumerState<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 15).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    // 初回メッセージをセット
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).reset(widget.char.initialMessage);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showQuestionPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "現代の悩みを相談する",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...demoQuestions.map((q) => ListTile(
              title: Text(q, style: const TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.chevron_right, size: 16),
              onTap: () {
                Navigator.pop(context);
                _askQuestion(q);
              },
            )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _askQuestion(String question) {
    ref.read(chatProvider.notifier).addMessage(question, false);
    // 回答生成アニメーションを挟む（擬似）
    Future.delayed(const Duration(milliseconds: 600), () {
      ref.read(chatProvider.notifier).generateVariedResponse(widget.char, question);
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);

    return Container(
      color: widget.char.color,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            
            // 偉人ビジュアル (反重力：ふわふわ浮かせるアニメーション)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: AppTheme.primaryWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.char.accent.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.char.image,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            Text(
              widget.char.name,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: widget.char.accent,
              ),
            ),
            Text(
              widget.char.title,
              style: TextStyle(
                fontSize: 16,
                color: widget.char.accent.withOpacity(0.7),
              ),
            ),
            
            const Spacer(),
            
            // チャットプレビュー（最新のメッセージを表示）
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.primaryWhite,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: widget.char.accent.withOpacity(0.2), width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Text(
                  messages.isNotEmpty ? messages.last.text : "...",
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 入力ボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: _showQuestionPicker,
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryWhite.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: widget.char.accent.withOpacity(0.4)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bolt, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "${widget.char.name}に相談する",
                        style: const TextStyle(
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }
}
