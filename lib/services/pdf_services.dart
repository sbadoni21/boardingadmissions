import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:boardingadmissions/views/chatpage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:boardingadmissions/services/chat/chat_services.dart';

import 'package:uuid/uuid.dart';


Future uploadPDF(File pdfPath, ChatService chatService, widget) async {
  String pdfFile = Uuid().v1();
  final Reference storageRef =
      FirebaseStorage.instance.ref().child('pdf').child('$pdfFile.pdf');

  if (kIsWeb) {
    // For web
    try {
      await storageRef.putFile(pdfPath);
      print('PDF uploaded to Firebase Storage.');
      String downloadURL = await storageRef.getDownloadURL();
      await chatService.sendMessage(widget.receiverUserId, downloadURL, 'pdf');
    } catch (e) {
      print('Error uploading PDF: $e');
    }
  } else {
    // For mobile (Android/iOS)
    try {
      await storageRef.putFile(pdfPath);
      print('PDF uploaded to Firebase Storage.');

      // Send a message with the download URL of the PDF
      String downloadURL = await storageRef.getDownloadURL();
      await chatService.sendMessage(widget.receiverUserId, downloadURL, 'pdf');
    } catch (e) {
      print('Error uploading PDF: $e');
    }
  }
}
