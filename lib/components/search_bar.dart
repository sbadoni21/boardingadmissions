import 'package:flutter/material.dart';

class SearchBarWithButton extends StatefulWidget {
  final String hintText;

  const SearchBarWithButton({Key? key, required this.hintText}) : super(key: key);

  @override
  State<SearchBarWithButton> createState() => _SearchBarWithButtonState();
}

class _SearchBarWithButtonState extends State<SearchBarWithButton> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      trailing: [
        const Icon(Icons.search),
        IconButton(
          icon: const Icon(Icons.keyboard_voice),
          onPressed: () {
            print('Use voice command');
          },
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {
            print('Use image search');
          },
        ),
      ],
      hintText: widget.hintText,
    );
  }
}
