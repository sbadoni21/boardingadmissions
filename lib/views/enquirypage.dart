import 'package:boardingadmissions/components/appbar_with_backbtn.dart';
import 'package:boardingadmissions/services/enquiry_services.dart';
import 'package:boardingadmissions/views/enquiry_submittedpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class EnquiryFormPage extends StatefulWidget {
  const EnquiryFormPage({Key? key}) : super(key: key);

  @override
  EnquiryFormPageState createState() => EnquiryFormPageState();
}

class EnquiryFormPageState extends State<EnquiryFormPage> {
  final List<String> schoolsNames = [
    'The Doon School',
    'Welham Boys\' School',
    'Welham Girls\' School',
    'Rashtriya Indian Military College (RIMC)',
    'St. George\'s College',
    'The Asian School',
    'Ecole Globale International Girls\' School',
    'The Heritage School',
    'Tula\'s International School',
    'SelaQui International School',
    'Col. Brown Cambridge School',
    'Mussoorie International School',
    'Kasiga School',
    'Army Public School, Birpur',
    'Hopetown Girls\' School',
    'Guru Nanak Fifth Centenary School',
    'Cambrian Hall',
  ];
  TextEditingController phoneNumberController = TextEditingController();

  List<String> selectedSchools = [];

  TextEditingController textEditingController = TextEditingController();
  ConfettiController _confettiController = ConfettiController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarWithBackButton(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Lottie.asset(
                    height: screenHeight / 3,
                    width: screenWidth,
                    "assets/lottie_animations/EnquiryLottieFile.json")),
            const Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
          const  Center(
              child: Text(
                "Enquire Now",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  labelText: 'Schools',
                ),
                icon: Icon(Icons.school_outlined),
                onChanged: (value) {
                  setState(() {
                    if (selectedSchools.contains(value)) {
                      selectedSchools.remove(value);
                    } else {
                      selectedSchools.add(value!);
                    }
                  });
                },
                items: schoolsNames.map((school) {
                  return DropdownMenuItem<String>(
                    value: school,
                    child: Text(school),
                  );
                }).toList(),
                hint: const Text('Select School(s)'),
                value: selectedSchools.isNotEmpty ? selectedSchools[0] : null,
              ),
            ),
            const SizedBox(height: 20.0),
            // Display selected schools as chips
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedSchools.map((school) {
                return InputChip(
                  label: Text(school),
                  onDeleted: () {
                    setState(() {
                      selectedSchools.remove(school);
                    });
                  },
                );
              }).toList(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone No.',
                  hintText: 'Enter your Mobile No.',
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
           const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Show confetti animation
                  _confettiController.play();
                  sendEmail(
                      phoneNumber: phoneNumberController.text,
                      schools: schoolsNames);

                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnquirySubmittedPage(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(180, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
