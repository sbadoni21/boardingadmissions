import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/teacher_info_component.dart';
import 'package:boardingadmissions/views/enquirypage.dart';
import 'package:boardingadmissions/views/faculty_page.dart';
import 'package:flutter/material.dart';

List facultymore = [
  {
    'image': "assets/photos/contact.png",
    'text': "Contact",
    'route': const FacultyInfo()
  },
  {
    'image': "assets/photos/suggestions.png",
    'text': "Suggestion",
    'route': const EnquiryFormPage()
  },
  {'image': "assets/photos/queries.png", 'text': "Queries", 'route': const EnquiryFormPage()}
];

class FacultyDescription extends StatefulWidget {
  const FacultyDescription({super.key});

  @override
  State<FacultyDescription> createState() => _FacultyDescriptionState();
}

class _FacultyDescriptionState extends State<FacultyDescription> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    constraints: BoxConstraints.tight(const Size.square(200)),
                    child: Image.asset(
                      "assets/photos/image8.png",
                      scale: 0.7,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shivang Rawat",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text("Senior Faculty")
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Divider(
                thickness: 0,
                color: Colors.blueAccent,
              ),
            ),
            const TeacherInfoDashboard(),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Divider(
                thickness: 0,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: facultymore.map((info) {
                      return SizedBox(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => info['route']));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(info["image"]),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(info['text'])
                            ],
                          ),
                        ),
                      );
                    }).toList())),
            const Padding(padding: EdgeInsets.all(20))
          ],
        ),
      ),
    );
  }
}
