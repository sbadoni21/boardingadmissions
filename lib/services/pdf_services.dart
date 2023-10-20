import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

Future uploadPDF(String pdfPath, String fileName) async {
  final Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

  if (kIsWeb) {
    // For web
    final blobFile = File(pdfPath); // Use File for web
    try {
      await storageRef.putFile(blobFile);
      print('PDF uploaded to Firebase Storage.');
    } catch (e) {
      print('Error uploading PDF: $e');
    }
  } else {
    // For Android
    final file = File(pdfPath);
    try {
      await storageRef.putFile(file);
      print('PDF uploaded to Firebase Storage.');
    } catch (e) {
      print('Error uploading PDF: $e');
    }
  }
}
