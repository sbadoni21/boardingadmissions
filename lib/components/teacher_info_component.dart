import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TeacherInfoDashboard extends StatefulWidget {
  @override
  _TeacherInfoDashboardState createState() => _TeacherInfoDashboardState();
}

class _TeacherInfoDashboardState extends State<TeacherInfoDashboard> {
  int selectedQueryIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final queries = [
    {
      'Query': 'MATH Chapter - 1',
      'progress': 0.7,
    },
    {
      'Query': 'Science Quiz',
      'progress': 0.5,
    },
    {
      'Query': 'History Assignment',
      'progress': 0.9,
    },
    {
      'Query': 'History Assignment',
      'progress': 0.9,
    },
  ];

  ElevatedButton buildQueryButton(String text, int index) {
    final isActive = selectedQueryIndex == index;
    final textColor = isActive ? Colors.purple : Colors.blue;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isActive ? Colors.white : Colors.white54,
        elevation: isActive ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0), // Rounded top corners
            bottom: Radius.zero, // Sharp bottom corners
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedQueryIndex = index;
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Faculty Description",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                buildQueryButton("Query 1", 0),
                buildQueryButton("Query 2", 1),
                buildQueryButton("Query 3", 2),
                buildQueryButton("Query 4", 3),
              ],
            ),
          ),
          Container(
            height: 300,
            child: PageView.builder(
              itemCount: queries.length,
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  selectedQueryIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final query = queries[index]; // Get the current query

                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                  child: Material(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors
                          .white, // Background color for the selected query
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 300 / queries.length,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white70,
                                      foregroundColor: Colors.blue,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          query['Query'] as String,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        CircularPercentIndicator(
                                          radius: 100 / queries.length,
                                          animation: true,
                                          animationDuration: 1200,
                                          lineWidth: 5,
                                          // percent: query['progress']
                                          // ,
                                          percent: 0.5,
                                          center: Text(
                                            "dskjb",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          circularStrokeCap:
                                              CircularStrokeCap.butt,
                                          backgroundColor: Colors.yellow,
                                          progressColor: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
