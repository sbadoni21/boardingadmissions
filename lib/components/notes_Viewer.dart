import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PDF Viewer'),
        ),
        body: Container(
            width: 500,
            height: 500,
            child: SfPdfViewer.asset("files/DECLARATION.pdf")));
  }
}
