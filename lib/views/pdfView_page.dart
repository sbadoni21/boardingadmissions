import 'package:boardingadmissions/components/appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;

  PDFViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const CustomAppBar(),
            body: SfPdfViewer.network(
              widget.pdfUrl,
              canShowScrollHead: false,
            )));
  }
}
