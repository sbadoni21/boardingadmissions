import 'package:boardingadmissions/components/appbar_with_backbtn.dart';
import 'package:boardingadmissions/models/topschools_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Define TopSchoolsResult at the top level
class TopSchoolsResult {
  final List<TopSchoolTile> topSchools;
  final String? error;

  TopSchoolsResult(this.topSchools, this.error);
}

class DescriptionPage extends StatefulWidget {
  DescriptionPage({Key? key}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TopSchoolTile> topSchools = [];

  @override
  void initState() {
    super.initState();
    fetchTopSchools();
  }

  Future<void> _loadImage(String imageUrl) async {
    try {
      await Image.network(imageUrl).image.resolve(ImageConfiguration.empty);
    } catch (e) {
      // Handle the error, e.g., log the error
      print("Error loading image: $e");
      // You can throw the error if you want to propagate it to the FutureBuilder's error field
      throw e;
    }
  }

  Future<void> fetchTopSchools() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('top_schools')
          .doc("doS5yZWLbhfkhasguA1g")
          .collection('school')
          .get();

      final List<TopSchoolTile> school = querySnapshot.docs.map((document) {
        final data = document.data() as Map<String, dynamic>;
        return TopSchoolTile.fromMap(data);
      }).toList();

      setState(() {
        topSchools = school;
        print(topSchools);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithBackButton(),
      body: topSchools.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show a loading indicator
          : ListView.builder(
              itemCount: topSchools.length,
              itemBuilder: (context, index) {
                final school = topSchools[index];
                return Container(
           
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                    elevation: 4, // Adjust the elevation as needed
                    shadowColor: Colors.grey, // Shadow color

                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Customize the border radius
                      ),
                      tileColor: Colors.white, // White background
                      leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10), // Use BorderRadius.circular to round the corners
                            border: Border.all(
                              color: Colors
                                  .black, // You can specify the border color
                              width: 1.0, // You can adjust the border width
                            ),
                          ),
                          width: 100,
                          child: FutureBuilder<void>(
                            future: _loadImage(school.imgUrl),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  // Handle the error, for example, display a placeholder or error message
                                  return Placeholder(); // Replace with your custom error widget
                                } else {
                                  // Image loaded successfully
                                  return Image.network(school.imgUrl);
                                }
                              } else {
                                // Display a loading indicator while the image is being fetched
                                return CircularProgressIndicator();
                              }
                            },
                          )),
                      title: Text(school.schoolName),
                      subtitle: Text('Location: ${school.location}'),
                      trailing: Text('Courses: ${school.noOfCoursesAvailable}'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
