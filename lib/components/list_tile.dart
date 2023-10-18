import 'package:flutter/material.dart';

class ListTileWithPhoto extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onProfilePressed;
  final VoidCallback onCallPressed;
  final VoidCallback onTextPressed;

  ListTileWithPhoto({
    required this.imageUrl,
    required this.onProfilePressed,
    required this.onCallPressed,
    required this.onTextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl), // Replace with your image URL
      ),
      title: Text('List Tile Title'), // Replace with your title
      subtitle: Text('List Tile Subtitle'), // Replace with your subtitle
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: onProfilePressed,
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: onCallPressed,
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: onTextPressed,
          ),
        ],
      ),
    );
  }
}
