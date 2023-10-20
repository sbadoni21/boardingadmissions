import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PDFViewerScreen {
  static Future<File> loadNetwork(String url) async {
    final response = await http
        .get(Uri.parse(url)); // Use Uri.parse() to convert the URL to a Uri.
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    // Add 'async' to the function.
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes,
        flush: true); // Pass 'bytes' to writeAsBytes.
    return file;
  }
}
