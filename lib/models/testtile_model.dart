import 'package:cloud_firestore/cloud_firestore.dart';






class testClassTile {
  final String className;

  testClassTile({required this.className});

  factory testClassTile.fromMap(Map<String, dynamic> map) {
    return testClassTile(className: map['tests']);
  }
}








class TestSubjectsTile {
  final String subjects;

  TestSubjectsTile({
    required this.subjects,
  });

  factory TestSubjectsTile.fromMap(Map<String, dynamic> map) {
    return TestSubjectsTile(
      subjects: map['subjects'],
    );
  }
}











class TestTopicsTile {
  final String topics;
  final String testUrl;

  TestTopicsTile({required this.topics, required this.testUrl});

  factory TestTopicsTile.fromMap(Map<String, dynamic> map) {
    return TestTopicsTile(topics: map['testname'], testUrl: map['testUrl']);
  }
}
