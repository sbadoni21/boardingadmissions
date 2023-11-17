import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:boardingadmissions/components/chatbubble.dart';
import 'package:boardingadmissions/services/pdf_services.dart';
import 'package:boardingadmissions/services/chat/chat_services.dart';
import 'package:boardingadmissions/services/pdf_services.dart';
import 'package:boardingadmissions/views/image_fullscreen_page.dart';
import 'package:boardingadmissions/views/pdfView_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.receiverProfilePhoto,
      required this.receiverDisplayName,
      required this.receiverUserId,
      required this.receiverUserEmail,
      required this.status,
      required this.receiverDeviceToken});
  final String receiverUserEmail;
  final String receiverUserId;
  final String receiverProfilePhoto;
  final String receiverDisplayName;
  final String status;
  final String receiverDeviceToken;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? imageFile;
  ImagePicker _picker = ImagePicker();
  bool isImagePickerActive = false;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text, 'Text');
      _messageController.clear();
    }
  }

  Future sendPDF(ChatService chatService, widget) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      final PlatformFile platformFile = result.files.first;
      final File pdfFile = File(platformFile.path as String);
      await uploadPDF(pdfFile, chatService, widget);
    }
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    if (!isImagePickerActive) {
      isImagePickerActive = true;
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      isImagePickerActive = false;
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        uploadImage();
      }
    }
  }

  Future getImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    if (!isImagePickerActive) {
      isImagePickerActive = true;
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);
      isImagePickerActive = false;
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        uploadImage();
      }
    }
  }

  Future requestCameraPermission() async {
    final permissions = <Permission>[
      Permission.camera,
      Permission.storage,
    ];
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    if (statuses[Permission.camera]!.isGranted &&
        statuses[Permission.storage]!.isGranted) {
      getImageFromCamera();
    } else {
      return;
    }
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
    await _chatService.sendMessage(widget.receiverUserId, imageUrl, 'Image');
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
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: widget.receiverProfilePhoto != null
                          ? NetworkImage(widget.receiverProfilePhoto!)
                              as ImageProvider // Cast to ImageProvider
                          : AssetImage(
                              'assets/image6.png'), // Use a placeholder image
                      radius: 20,
                      // Adjust the size as needed
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.receiverDisplayName != null
                          ? widget.receiverDisplayName as String
                          : "Username",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 15, 33, 47),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.status == 'Online' ? 'Online' : "Offline",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 15, 33, 47),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            // Adjust margin as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Add rounded corners
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Apply rounded corners
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  prefixIcon: IconButton(
                    onPressed: () => sendPDF(_chatService, widget),
                    icon: Icon(
                      Icons.attach_file,
                      color: Colors.blueAccent,
                    ),
                  ),

                  hintStyle:
                      TextStyle(color: Colors.black), // Set text color to black
                ),
                controller: _messageController,
                obscureText: false,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => getImage(),
                  icon: Icon(
                    Icons.photo,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () => requestCameraPermission(),
                  icon: Icon(
                    Icons.photo_camera,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(50), // Define the border radius
                    color: Colors.blue, // Set the background color
                  ),
                  child: IconButton(
                    onPressed: () async {
                      sendMessage();
                      var data = {
                        'to': widget.receiverDeviceToken,
                        'priority': 'high',
                        'notification': {
                          'title': 'Boarding Admissions',
                          'body': "New message from " +
                              _firebaseAuth.currentUser!.displayName.toString(),
                        },
                        'data': {
                          'type': "Chat",
                        }
                      };
                      await http.post(
                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                          body: jsonEncode(data),
                          headers: {
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Authorization':
                                'key=AAAANcq0PWM:APA91bGcMj1zySNAMfzj-tUSslTU1q5wSYMA967ndBM0Z_j0LoVagvzzk2nv-dwavXOtJ-B-uT4jUmNKfWyi-oV2Q5x9IhODo8wjWBbGx3mLuumEdkK5xEF1qxB8xA4gags2IZP5qKnN'
                          });
                    },
                    icon: const Icon(
                      Icons.send_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
              ChatBubble(
                  message: data['message'],
                  seen: data['seen'],
                  timestamp: data['timestamp']),
            ],
          ),
        ),
      );
    } else if (data['type'] == 'Image') {
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageEnlargedView(imageUrl: data['message']),
                    ),
                  );
                },
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
    } else if (data['type'] == 'pdf') {
      return Container(
        alignment: alignment,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SfPdfViewer.network(data['message']),
                    ),
                  );
                },
                child: Text("pdf"),
              ),
            ],
          ),
        ),
      );
    } else {
      return SnackBar(content: Text('ERROR'));
    }
  }

  Widget _buildMessageList() {
    List<Map<String, dynamic>> messages = [];
    DateTime? currentDate;

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
          for (var doc in snapshot.data!.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            
     
            DateTime? messageDate = (data['timestamp'] as Timestamp?)?.toDate();

            if (messageDate != null) {
              if (currentDate == null || !isSameDay(currentDate, messageDate)) {
                messages.add({'isDivider': true, 'date': messageDate});
                currentDate = messageDate;
              }

              messages.add({'isDivider': false, 'message': data});
            }
          }

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              if (messages[index]['isDivider']) {
                // Display the date divider
                DateTime date = messages[index]['date'];
                String formattedDate =
                    DateFormat.yMMMd().format(date); // Format the date
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(2, 84, 152, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      formattedDate,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                );
              } else {
                // Display the message
                return _buildMessageItem(messages[index]['message']);
              }
            },
          );
        }
      },
    );
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false; // Consider them not the same day if either is null
    }
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
