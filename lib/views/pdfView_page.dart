import 'dart:io';
import 'package:boardingadmissions/components/appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class PDFViewerPage extends StatefulWidget {
  // final String pdfUrl;

  // PDFViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:CustomAppBar(),
        // body: SfPdfViewer.asset('assets/files/DECLARATION.pdf'),
        body: SfPdfViewer.network('https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        enableTextSelection: true,
        canShowScrollHead: true,
        canShowPageLoadingIndicator: true,
         initialScrollOffset: Offset(0, 500),
              initialZoomLevel: 1.5
        
        ),
      ),
    );
  }
}
