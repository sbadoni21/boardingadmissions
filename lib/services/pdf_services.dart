import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

Future<void> get1() async {
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  final CollectionReference socialMessage =
      FirebaseFirestore.instance.collection('pdf');
  var value = await socialMessage.get();
  logger.i(value);
}

Future uploadPDF(String pdfPath, String fileName) async {
  get1();
  final Reference storageRef = FirebaseStorage.instance.ref().child('pdf').child('$fileName.pdf');

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
Future<Map<String, String>> pdfData() async {
  const String collection = 'pdf';
  String path = '';
  String name = '';
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();

  if (querySnapshot.docs.isNotEmpty) {
    final Map<String, dynamic>? firstDocData =
        querySnapshot.docs[0].data() as Map<String, dynamic>?;

    if (firstDocData != null &&
        firstDocData.containsKey("path") &&
        firstDocData.containsKey('name')) {
      path = firstDocData["path"];
      name = firstDocData['name'];
    } else {
      print("Field 'path' or 'name' is not present or is null in the first document.");
    }
  } else {
    print("Not Found");
  }

  // Return a Map with 'name' and 'path'
  return {'name': name, 'path': path};
}
