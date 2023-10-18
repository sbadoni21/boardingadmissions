import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/list_tile.dart';
import 'package:boardingadmissions/components/search_bar.dart';
import 'package:flutter/material.dart';

class FacultyInfo extends StatefulWidget {
  const FacultyInfo({super.key});

  @override
  State<FacultyInfo> createState() => _FacultyInfoState();
}

class _FacultyInfoState extends State<FacultyInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Scaffold(
          appBar: CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SearchBarWithButton(hintText: "Search here..."),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Staff Available for Student",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 13, color: Colors.blueAccent),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTileWithPhoto(
                  imageUrl: 'assets/photos/image8.png',
                  onProfilePressed: () {
                    // Handle profile button press
                  },
                  onCallPressed: () {
                    // Handle call button press
                  },
                  onTextPressed: () {
                    // Handle text button press
                  },
                ),
                ListTileWithPhoto(
                  imageUrl: 'assets/photos/image8.png',
                  onProfilePressed: () {
                    // Handle profile button press
                  },
                  onCallPressed: () {
                    // Handle call button press
                  },
                  onTextPressed: () {
                    // Handle text button press
                  },
                ),
                ListTileWithPhoto(
                  imageUrl: 'assets/photos/image8.png',
                  onProfilePressed: () {
                    // Handle profile button press
                  },
                  onCallPressed: () {
                    // Handle call button press
                  },
                  onTextPressed: () {
                    // Handle text button press
                  },
                ),
                ListTileWithPhoto(
                  imageUrl: 'assets/photos/image8.png',
                  onProfilePressed: () {
                    // Handle profile button press
                  },
                  onCallPressed: () {
                    // Handle call button press
                  },
                  onTextPressed: () {
                    // Handle text button press
                  },
                ),
                ListTileWithPhoto(
                  imageUrl: 'assets/photos/image8.png',
                  onProfilePressed: () {
                    // Handle profile button press
                  },
                  onCallPressed: () {
                    // Handle call button press
                  },
                  onTextPressed: () {
                    // Handle text button press
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
