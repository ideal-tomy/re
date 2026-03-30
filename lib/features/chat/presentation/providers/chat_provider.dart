import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:re/features/character/data/models/character_model.dart';
import 'package:re/features/chat/data/demo_responses.dart';

class Message {
  final String text;
  final bool isFromAi;
  Message({required this.text, required this.isFromAi});
}

class ChatNotifier extends StateNotifier<List<Message>> {
  ChatNotifier() : super([]);

  void addMessage(String text, bool isFromAi) {
    state = [...state, Message(text: text, isFromAi: isFromAi)];
  }

  void reset(String initialMessage) {
    state = [Message(text: initialMessage, isFromAi: true)];
  }

  // デモ用の多パターンランダム応答
  void generateVariedResponse(Character character, String? question) {
    final responses = allDemoResponses[character.id];
    if (responses == null || responses.isEmpty) {
      addMessage("...（沈黙している）", true);
      return;
    }

    final tag = question != null ? questionTags[question] : null;
    
    // 特定のタグの回答を探すか、なければランダムに選択
    final relevantResponses = tag != null 
        ? responses.where((r) => r.questionTag == tag).toList()
        : responses;

    if (relevantResponses.isEmpty) {
      addMessage("...（深く考え込んでいる）", true);
      return;
    }

    final randomResponse = relevantResponses[Random().nextInt(relevantResponses.length)];
    final variation = randomResponse.variations[Random().nextInt(randomResponse.variations.length)];
    
    addMessage(variation, true);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<Message>>((ref) {
  return ChatNotifier();
});
