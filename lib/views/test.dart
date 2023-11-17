import 'package:boardingadmissions/models/testtile_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Future<List<TestTopicsTile>> futureSubjects;

  @override
  void initState() {
    super.initState();
    // Initialize the futureSubjects in initState
    futureSubjects = fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TestTopicsTile>>(
        future: futureSubjects, // Use the futureSubjects variable
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
                      // Use setState to trigger a rebuild with the updated futureSubjects
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
            return ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                TestTopicsTile selectedSubject = subjects[index];
                return ListTile(
                  title: Text(selectedSubject
                      .topics), // Use the appropriate field from your model
                  onTap: () {
                    // You can navigate to the next screen or perform other actions here
                  },
                );
              },
            );
          }
        },
      ),
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
    throw e; // Rethrow the error so that it can be caught in the FutureBuilder
  }
}
