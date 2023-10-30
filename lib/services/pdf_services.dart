import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:boardingadmissions/services/chat/chat_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

Future SendPDF(ChatService chatService, widget) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  File pdfFile;
 if (result != null && result.files.isNotEmpty) {
    final PlatformFile platformFile = result.files.first;
    final File pdfFile = File(platformFile.path!);
    await uploadPDF(pdfFile, chatService, widget);
  }
}
 


Future uploadPDF(File? pdfPath, ChatService chatService, widget) async {
  String pdfFile = Uuid().v1();
  final Reference storageRef =
      FirebaseStorage.instance.ref().child('pdf').child('$pdfFile.pdf');

  if (kIsWeb) {
    // For web
    final blobFile = File(pdfPath as String); // Use File for web
    try {
      await storageRef.putFile(blobFile);
      print('PDF uploaded to Firebase Storage.');

      // Send a message with the download URL of the PDF
      String downloadURL = await storageRef.getDownloadURL();
      await chatService.sendMessage(widget.receiverUserId, downloadURL, 'pdf');
    } catch (e) {
      print('Error uploading PDF: $e');
    }
  } else {
    // For mobile (Android/iOS)
    final file = File(pdfPath as String);
    try {
      await storageRef.putFile(file);
      print('PDF uploaded to Firebase Storage.');

      // Send a message with the download URL of the PDF
      String downloadURL = await storageRef.getDownloadURL();
      await chatService.sendMessage(widget.receiverUserId, downloadURL, 'PDF');
    } catch (e) {
      print('Error uploading PDF: $e');
    }
  }
}
