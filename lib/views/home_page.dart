import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/compatibilitycomponent.dart';
import 'package:boardingadmissions/components/dreamschool_component.dart';
import 'package:boardingadmissions/components/sample_classes.dart';
import 'package:boardingadmissions/components/testpdf_component.dart';
import 'package:boardingadmissions/views/enquirypage.dart';
import 'package:boardingadmissions/views/chatapp.dart';
import 'package:boardingadmissions/views/profile_page.dart';
import 'package:boardingadmissions/views/schools_bottomNav.dart';
import 'package:boardingadmissions/views/test.dart';
import 'package:boardingadmissions/views/test_page.dart';
import 'package:boardingadmissions/views/upi_payment.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentIndex = 0;
  bool isLoading = true;
  final PageController _pageController = PageController(initialPage: 0);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // NotificationService().initialize(context);
  }

  void setStatus(String status) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({'status': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('Online');
    } else {
      setStatus('Offline');
    }
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  final List<String> imageUrls = [
    'assets/image1.png',
    'assets/image1.png',
    'assets/image1.png',
  ];

  final List<Map<String, String>> imageSchools = [
    {"schoolName": "School 1", "imageUrl": "assets/school2.png"},
    {"schoolName": "School 2", "imageUrl": "assets/school2.png"},
    {"schoolName": "School 3", "imageUrl": "assets/school2.png"},
  ];

  final List<Map<String, String>> dreamSchools = [
    {"schoolName": "School 1", "imageUrl": "assets/school2.png"},
    {"schoolName": "School 2", "imageUrl": "assets/school4.png"},
    {"schoolName": "School 3", "imageUrl": "assets/school5.png"},
    {"schoolName": "School 4", "imageUrl": "assets/school6.png"},
    {"schoolName": "School 3", "imageUrl": "assets/school5.png"},
    {"schoolName": "School 4", "imageUrl": "assets/school6.png"},
  ];

  final List<String> buttonTitles = [
    "Class 6 - Science",
    "Class 7 - Math",
    "Class 8 - History",
    "Class 8 - Physics"
  ];

  final List<FaqItem> faqItems = [
    FaqItem(
      question: "Questin 1",
      answer: "Answer 1",
    ),
    FaqItem(
      question: "Question 2",
      answer: "Answer 2",
    ),
    FaqItem(
      question: "Question 3",
      answer: "Answer 3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return homeScreenPage();
  }

  Widget homeScreenPage() {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: IndexedStack(index: _currentIndex, children: [
          buildHomePage(),
          const ProfilePage(),
          const SchoolsBottomNavBar(),
          const ChatApp(),
          TestPage()
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: _currentIndex == 0 ? 5 : 0,
                    shadowColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), // Elevation when selected
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.home,
                          color:
                              _currentIndex == 0 ? Colors.blue : Colors.grey),
                      Text("Home",
                          style: TextStyle(
                              color: _currentIndex == 0
                                  ? Colors.blue
                                  : Colors.grey))
                    ],
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
              icon: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: _currentIndex == 1 ? 5 : 0,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), // Elevation when selected
                ),
                child: Column(
                  children: [
                    Icon(Icons.person,
                        color: _currentIndex == 1 ? Colors.blue : Colors.grey),
                    Text("Profile",
                        style: TextStyle(
                            color:
                                _currentIndex == 1 ? Colors.blue : Colors.grey))
                  ],
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: _currentIndex == 2 ? 5 : 0,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), // Elevation when selected
                ),
                child: Column(
                  children: [
                    Icon(Icons.school_rounded,
                        color: _currentIndex == 2 ? Colors.blue : Colors.grey),
                    Text("Schools",
                        style: TextStyle(
                            color:
                                _currentIndex == 2 ? Colors.blue : Colors.grey))
                  ],
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: _currentIndex == 3 ? 5 : 0,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // Elevation when selected
                ),
                child: Column(children: [
                  Icon(Icons.chat_bubble_outline,
                      color: _currentIndex == 3 ? Colors.blue : Colors.grey),
                  Text(
                    "chat",
                    style: TextStyle(
                        color: _currentIndex == 3 ? Colors.blue : Colors.grey),
                  )
                ]),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: _currentIndex == 4 ? 5 : 0,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // Elevation when selected
                ),
                child: Column(children: [
                  Icon(Icons.chat_bubble_outline,
                      color: _currentIndex == 4 ? Colors.blue : Colors.grey),
                  Text(
                    "test",
                    style: TextStyle(
                        color: _currentIndex == 4 ? Colors.blue : Colors.grey),
                  )
                ]),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHomePage() {
    return SizedBox(
      child: ListView(
        children: [
          CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              );
            }).toList(),
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 184,
            height: 40,
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpiPaymentScreen()));
              },
              child: const Text(
                'Join Now',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'BCT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          OptionsColumn(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Divider(
              thickness: 0.5,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Sample Classes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TestPdfComponentPage(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Divider(
              thickness: 0.5,
              color: Colors.blue,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Top Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SampleClasses(),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              color: Colors.blue,
              thickness: .5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "What we offer",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(children: [
                  ExpansionPanelList(
                    elevation: 2,
                    materialGapSize: 5,
                    expandedHeaderPadding: const EdgeInsets.all(10),
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        faqItems[index].isExpanded = isExpanded;
                      });
                    },
                    children: faqItems.map<ExpansionPanel>((FaqItem faqItem) {
                      return ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            minVerticalPadding: 10,
                            textColor: Colors.blue,
                            title: Text(faqItem.question),
                          );
                        },
                        body: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(faqItem.answer),
                        ),
                        isExpanded: faqItem.isExpanded,
                      );
                    }).toList(),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25))
                ])
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              color: Colors.blue,
              thickness: .5,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Dream Schools',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SchoolList(schools: dreamSchools),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Divider(
              color: Colors.blue,
              thickness: .5,
            ),
          ),
        ],
      ),
    );
  }
}
