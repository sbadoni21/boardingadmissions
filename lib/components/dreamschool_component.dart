import 'package:flutter/material.dart';

class SchoolList extends StatelessWidget {
  final List<Map<String, String>> schools;

  SchoolList({required this.schools});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: schools.map((school) {
            final String? schoolName = school["schoolName"];
            final String? imageUrl = school["imageUrl"];
            if (schoolName != null && imageUrl != null) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
                        minimumSize: const Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(120.0),
                        ),
                        shadowColor: Colors.black87,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Image.asset(
                              imageUrl,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    schoolName,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                  )
                ],
              );
            } else {
              return Container();
            }
          }).toList(),
        ),
      ),
    );
  }
}
