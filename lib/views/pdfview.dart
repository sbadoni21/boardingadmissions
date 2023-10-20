// import 'package:boardingadmissions/components/notes_viewer.dart'; // Ensure the correct import path.
// import 'package:boardingadmissions/views/pdfView_page.dart';
// import 'package:flutter/material.dart';



// class PdfScreen extends StatefulWidget {
//   const PdfScreen({Key? key})
//       : super(key: key); // Fix the constructor and super call.

//   @override
//   State<PdfScreen> createState() => _PdfScreenState();
// }

// class _PdfScreenState extends State<PdfScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//         body: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   const url =
//                       'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf';
//                   final file = await PDFViewerScreen.loadNetwork(url);
//                   openPDF(context, file);
//                 } catch (e) {
//                   // Handle the exception here
//                   print(e);
//                   // You can display an error message or take appropriate action.
//                 }
//               },
//               child: Text("Click me"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void openPDF(BuildContext context, file) {
//     Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => PDFViewerPage(pdfUrl: file)));
//   }
// }
