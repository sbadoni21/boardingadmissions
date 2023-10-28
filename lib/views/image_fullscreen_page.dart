import 'package:flutter/material.dart';
import 'package:boardingadmissions/components/appbar_with_backbtn.dart';

class ImageEnlargedView extends StatefulWidget {
  final String? imageUrl; // Define imageUrl as a parameter

  ImageEnlargedView({Key? key, this.imageUrl}) : super(key: key);

  @override
  _ImageEnlargedViewState createState() => _ImageEnlargedViewState();
}

class _ImageEnlargedViewState extends State<ImageEnlargedView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarWithBackButton(),
        body: Center(
          child: Image.network(widget.imageUrl!),
        ),
      ),
    );
  }
}
