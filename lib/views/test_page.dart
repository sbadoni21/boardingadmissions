import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

class TestSection extends StatefulWidget {
  @override
  _TestSectionState createState() => _TestSectionState();
}

class _TestSectionState extends State<TestSection> {
  bool _isTestCompleted = false;
  int _remainingTime = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _isTestCompleted
                ? Center(
                    child: Text('Test Completed!'),
                  )
                : Center(
                    child: Text('Your PDF Viewer Widget Here'),
                  ),
          ),
          _isTestCompleted
              ? Container() // Empty container when the test is completed
              : Text('Time Remaining: $_remainingTime seconds'),
          ElevatedButton(
            onPressed: _isTestCompleted
                ? null
                : () {
                    _showConfirmationDialog();
                  },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to submit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _pickImagesAndUploadToFirebase();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImagesAndUploadToFirebase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      final pdfDocument = pw.Document();

      for (var imageFile in result.paths!.map((path) => File(path!))) {
        final image = img.decodeImage(imageFile.readAsBytesSync())!;
        final pdfImage =
            pw.MemoryImage(Uint8List.fromList(img.encodePng(image)));

        pdfDocument.addPage(pw.Page(build: (context) {
          return pw.Image(pdfImage);
        }));
      }

      final output = Uint8List.fromList(await pdfDocument.save());

      // Upload to Firebase Storage
      final storage = firebase_storage.FirebaseStorage.instance;
      final storageRef = storage.ref().child('pdfs').child(
          'merged_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await storageRef.putData(output);

      print('PDF uploaded to Firebase Storage');
    }
  }
}
