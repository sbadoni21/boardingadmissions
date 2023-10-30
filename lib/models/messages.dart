import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final String type;
  bool seen;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.seen,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'type': type,
      'seen': false,
    };
  }
}