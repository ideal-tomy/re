import 'package:flutter/material.dart';

class Character {
  final String id;
  final String name;
  final String title;
  final Color color;
  final Color accent;
  final String image;
  final String status;
  final String favor;
  final String initialMessage;
  final String category;
  final String description;

  const Character({
    required this.id,
    required this.name,
    required this.title,
    required this.color,
    required this.accent,
    required this.image,
    required this.status,
    required this.favor,
    required this.initialMessage,
    required this.category,
    required this.description,
  });
}

final List<Character> dummyCharacters = [
  Character(
    id: 'AI-01',
    name: 'ソクラテス',
    title: '無知の知の探求者',
    color: const Color(0xFFF1F8E9),
    accent: const Color(0xFF689F38),
    image: '🏺',
    status: '問答を待っている',
    favor: '親密 (60%)',
    initialMessage: '君よ、教えてくれ。君が「分かっている」と思っていることは、本当に真理かな？',
    category: '哲学系',
    description: '古代ギリシャの哲学者。問答法（産婆術）を通じて、相手に自らの無知を気づかせ、真の知への道を示した。',
  ),
  Character(
    id: 'AI-02',
    name: 'アリストテレス',
    title: '万学の祖',
    color: const Color(0xFFE0F7FA),
    accent: const Color(0xFF0097A7),
    image: '📜',
    status: '分類中...',
    favor: '普通 (55%)',
    initialMessage: 'ようこそ。万物の原因と秩序について、論理的に解き明かしていこうじゃないか。',
    category: '哲学系',
    description: 'プラトンの弟子であり、論理学、生物学、政治学など多岐にわたる学問の基礎を築いた。現実世界を重視する。',
  ),
  Character(
    id: 'AI-03',
    name: 'プラトン',
    title: 'イデア論の提唱者',
    color: const Color(0xFFE1F5FE),
    accent: const Color(0xFF0288D1),
    image: '🏛️',
    status: '洞窟の外を見ている',
    favor: '普通 (50%)',
    initialMessage: 'この現実世界は、イデアの影に過ぎない。さあ、魂を光の方へと向き直そう。',
    category: '哲学系',
    description: 'ソクラテスの弟子。不変の「イデア」こそが真の実在であると説き、理想国家のあり方を追求した。',
  ),
  Character(
    id: 'AI-04',
    name: '孔子',
    title: '至聖先師',
    color: const Color(0xFFF5F5DC),
    accent: const Color(0xFF5D4037),
    image: '🎋',
    status: '礼を説いている',
    favor: '普通 (45%)',
    initialMessage: '学びて時に之を習う、亦た説（よろこ）ばしからずや。仁の心について語り合おう。',
    category: '思想家',
    description: '中国春秋時代の思想家。仁（思いやり）と礼（秩序）を重んじ、徳による政治と人格形成を説いた。',
  ),
  Character(
    id: 'AI-05',
    name: '釈迦（ブッダ）',
    title: '目覚めた人',
    color: const Color(0xFFFFF9C4),
    accent: const Color(0xFFFBC02D),
    image: '🧘',
    status: '深い静寂の中',
    favor: '普通 (50%)',
    initialMessage: '執着を離れ、あるがままに観察しなさい。苦しみの源泉を見つめるのだ。',
    category: '思想家',
    description: '仏教の開祖。四諦、八正道、緑起などの法を悟り、生老病死の苦しみから解脱する道を説いた。',
  ),
];
