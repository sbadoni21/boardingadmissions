import 'package:boardingadmissions/components/chat_nav_bar_component.dart';
import 'package:boardingadmissions/components/chatbubble.dart';
import 'package:boardingadmissions/services/chat/chat_services.dart';
import 'package:boardingadmissions/views/chatapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.receiverProfilePhoto,
    required this.receiverDisplayName,
    required this.receiverUserId,
    required this.receiverUserEmail,
  });
  final String receiverUserEmail;
  final String receiverUserId;
  final String receiverProfilePhoto;
  final String receiverDisplayName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? imageFile;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text, 'Text');
      _messageController.clear();
    }
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((XFile) {
      if (XFile != null) {
        imageFile = File(XFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();

    var ref =
        FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');

    var uploadTask = await ref.putFile(imageFile!);
    String ImageUrl = await uploadTask.ref.getDownloadURL();
    sendImage(ImageUrl);
  }

  Future sendImage(String imageUrl) async {
    _chatService.sendMessage(widget.receiverUserId, imageUrl, 'Image');
  }

  String? displayName;
  String? profilePhoto;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.8),
                  Colors.white,
                ],
                stops: const [0.0, 1],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ;
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    )),
                Container(
                  width: 150,
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: CircleAvatar(
                    backgroundImage: widget.receiverProfilePhoto != null
                        ? NetworkImage(widget.receiverProfilePhoto!)
                            as ImageProvider // Cast to ImageProvider
                        : AssetImage(
                            'assets/placeholder_image.png'), // Use a placeholder image
                    radius: 20,
                    // Adjust the size as needed
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  widget.receiverDisplayName != null
                      ? widget.receiverDisplayName as String
                      : "Username",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 15, 33, 47),
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
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
              margin: const EdgeInsets.all(10), // Adjust margin as needed
              decoration: BoxDecoration(
                color: Colors.white, // Set background color
                borderRadius: BorderRadius.circular(10), // Add rounded corners
              ),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => getImage(), icon: Icon(Icons.photo))),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    if (data['type'] == 'Text') {
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
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 2,
              ),
              ChatBubble(message: data['message'])
            ],
          ),
        ),
      );
    } else {
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
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: Image.network(
                    data['message'],
                    height: 350,
                    width: 350,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
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
