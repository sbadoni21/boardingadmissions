import 'package:boardingadmissions/components/appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:boardingadmissions/services/pdf_services.dart';

Future<void> processPdfData() async {
  try {
    final Map<String, String> pdfInfo = await pdfData();
    // Now you can access 'name' and 'path' from pdfInfo
    String name = pdfInfo['name'] ??
        "Default Name"; // Use a default value if 'name' is null
    String path = pdfInfo['path'] ?? "Default Path";
    List<Map<String, String>> pdfDATA = [
      {
        'pdfName': name,
        'onpress': path,
      }
    ];

    // Do something with name and path
    print("Name: $name");
    print("Path: $path");

    // You can perform other operations in this function as needed.
  } catch (e) {
    print("Error: $e");
  }
}

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
        appBar: CustomAppBar(),
        body: SfPdfViewer.asset('assets/files/DECLARATION.pdf'),
        // body: SfPdfViewer.network(pdfData(),
        // enableTextSelection: true,
        // canShowScrollHead: true,
        // canShowPageLoadingIndicator: true,
        //  initialScrollOffset: Offset(0, 500),
        //       initialZoomLevel: 1.5

        // ),
      ),
    );
  }
}
