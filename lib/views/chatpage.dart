import 'package:boardingadmissions/components/appbar_with_backbtn.dart';
import 'package:boardingadmissions/components/chatbubble.dart';
import 'package:boardingadmissions/services/chat/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  });
  final String receiverUserEmail;
  final String receiverUserId;
 

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUserId,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBarWithBackButton(),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10), // Adjust margin as needed
              decoration: BoxDecoration(
                color: Colors.white, // Set background color
                borderRadius: BorderRadius.circular(10), // Add rounded corners
              ),
              child: TextField(
                controller: _messageController,
                obscureText: false,
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      // Expand horizontally
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(
              data['senderEmail'],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 2,
            ),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
        _firebaseAuth.currentUser!.uid,
        widget.receiverUserId,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return ListView(
            children: snapshot.data!.docs
                .map((doc) =>
                    _buildMessageItem(doc.data() as Map<String, dynamic>))
                .toList(),
          );
        }
      },
    );
  }
}
