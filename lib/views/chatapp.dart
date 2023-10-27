import 'package:boardingadmissions/components/appbar_with_backbtn.dart';
import 'package:boardingadmissions/views/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithBackButton(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading...");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItems(context, doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItems(BuildContext context, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: data['profilePhoto'] != null
                      ? NetworkImage('profilePhoto')
                          as ImageProvider // Cast to ImageProvider
                      : AssetImage(
                          'assets/placeholder_image.png'), // Use a placeholder image
                  radius: 20, // Adjust the size as needed
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  data['displayName'],
                ),
              ],
            ),
            Icon(
              Icons.messenger_outline,
              color: data['status'] == 'Online' ? Colors.green : Colors.red,
            )
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverUserEmail: (data['email']) as String,
                        receiverUserId: (data['uid']) as String,
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
