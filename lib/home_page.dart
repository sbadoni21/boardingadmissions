import 'package:boardingadmissions/chat.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:boardingadmissions/profile_page.dart';

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
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<String> imageUrls = [
    'image1.png',
    'image1.png',
    'image1.png',
  ];

  final List<Map<String, String>> imageSchools = [
    {"schoolName": "School 1", "imageUrl": "school2.png"},
    {"schoolName": "School 2", "imageUrl": "school2.png"},
    {"schoolName": "School 3", "imageUrl": "school2.png"},
  ];

  final List<Map<String, String>> dreamSchools = [
    {"schoolName": "School 1", "imageUrl": "school2.png"},
    {"schoolName": "School 2", "imageUrl": "school4.png"},
    {"schoolName": "School 3", "imageUrl": "school5.png"},
    {"schoolName": "School 4", "imageUrl": "school6.png"},
  ];

  final List<String> buttonTitles = [
    "Class 6 - Science",
    "Class 7 - Math",
    "Class 8 - History",
    "Class 8 - Physics"
  ];

  final List<FaqItem> faqItems = [
    FaqItem(
      question: "Question 1",
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 76,
        elevation: 0,
        flexibleSpace: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.8),
                Colors.white,
              ],
              stops: const [
                0.0,
                0.8,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Image.asset(
                  'logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search,
                          size: 30, color: Color.fromRGBO(2, 84, 152, 1)),
                      onPressed: () {
                        // Handle search icon press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu,
                          size: 30, color: Color.fromRGBO(2, 84, 152, 1)),
                      onPressed: () {
                        // Handle notifications icon press
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          buildHomePage(),
          ProfilePage(),
          buildNotificationScreen(),
          Chat(), // Replace with your SettingsScreen
        ],
      ),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Settings',
          ),
        ],
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
            width: 60,
            padding: EdgeInsets.only(left: 100, right: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                // Handle the "Join" button press
              },
              child: const Text(
                'Join Now',
              ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttonTitles.map((title) {
                return ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
                    minimumSize: const Size(100, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Colors.black54,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title.split('-')[0],
                        style: const TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      Text(
                        title.split('-')[1],
                        style: const TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: imageSchools.map((school) {
              final String? schoolName = school["schoolName"];
              final String? imageUrl = school["imageUrl"];
              if (schoolName != null && imageUrl != null) {
                return ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
                    minimumSize: const Size(100, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Colors.black54,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          imageUrl,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              schoolName,
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }).toList(),
          ),
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
                    expandedHeaderPadding: EdgeInsets.all(10),
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        faqItems[index].isExpanded = isExpanded;
                      });
                    },
                    children: faqItems.map<ExpansionPanel>((FaqItem faqItem) {
                      return ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Color.fromRGBO(248, 248, 248, 1),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            minVerticalPadding: 10,
                            textColor: Colors.blue,
                            title: Text(faqItem.question),
                          );
                        },
                        body: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(faqItem.answer),
                        ),
                        isExpanded: faqItem.isExpanded,
                      );
                    }).toList(),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25))
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dreamSchools.map((school) {
              final String? schoolName = school["schoolName"];
              final String? imageUrl = school["imageUrl"];
              if (schoolName != null && imageUrl != null) {
                return Column(
                  children: [
                    ElevatedButton(
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

  Widget buildNotificationScreen() {
    return Center(
      child: Text(
        'Notification Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}