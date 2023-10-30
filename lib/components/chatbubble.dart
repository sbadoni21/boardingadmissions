import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  bool seen;
  ChatBubble({super.key, required this.message, required this.seen});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: seen ? Colors.blue : Colors.greenAccent),
      child: Text(
        message,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}