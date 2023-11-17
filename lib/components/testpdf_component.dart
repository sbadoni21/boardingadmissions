import 'package:boardingadmissions/views/pdfView_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestTopicsTile {
  final String topics;
  final String testUrl;

  TestTopicsTile({required this.topics, required this.testUrl});
}

class TestPdfComponentPage extends StatefulWidget {
  TestPdfComponentPage({Key? key}) : super(key: key);

  @override
  State<TestPdfComponentPage> createState() => _TestPdfComponentPageState();
}

class _TestPdfComponentPageState extends State<TestPdfComponentPage> {
  late Future<List<TestTopicsTile>> futureSubjects;

  @override
  void initState() {
    super.initState();
    futureSubjects = fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TestTopicsTile>>(
      future: futureSubjects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No subjects available'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      futureSubjects = fetchSubjects();
                    });
                  },
                  child: Text('Reload Subjects'),
                ),
              ],
            ),
          );
        } else {
          List<TestTopicsTile> subjects = snapshot.data!;
          return Container(
            height: 150, // Set a fixed height for the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                TestTopicsTile subject = subjects[index];
                return Container(
                  width: 150,
                  child: Card(
                    child: ListTile(
                      title: Text(subject.topics),
                      onTap: () {
                        print(subject.testUrl);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PDFViewerPage(pdfUrl: subject.testUrl)));
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

Future<List<TestTopicsTile>> fetchSubjects() async {
  try {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("tests")
        .doc("XriIs7P4yVGoOLqznlDo")
        .collection("class5")
        .doc("72bdRQXaGrgzHqQkQ3lf")
        .collection('Mathematics')
        .get();

    final List<TestTopicsTile> subjects = querySnapshot.docs.map((document) {
      final data = document.data() as Map<String, dynamic>;

      String subjectName = data['testname'].toString();
      String subjectUrl = data['testUrl'].toString();

      return TestTopicsTile(topics: subjectName, testUrl: subjectUrl);
    }).toList();

    return subjects;
  } catch (e) {
    print("Error fetching subjects: $e");
    throw e;
  }
}
