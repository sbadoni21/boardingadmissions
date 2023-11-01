import 'package:cloud_firestore/cloud_firestore.dart';

class TopSchoolTile {
  final String imgUrl;
  final String schoolName;
  final String location;
  final int noOfCoursesAvailable;

  TopSchoolTile({
    required this.imgUrl,
    required this.schoolName,
    required this.noOfCoursesAvailable,
    required this.location,
  });

  factory TopSchoolTile.fromMap(Map<String, dynamic> map) {
    return TopSchoolTile(
      imgUrl: map['imgUrl'],
      schoolName: map['schoolName'],
      noOfCoursesAvailable: map['noOfCoursesAvailable'],
      location: map['location'],
    );
  }
}
