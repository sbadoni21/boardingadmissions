import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedQueryIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<String> queries = [
    'Query 1',
    'Query 2',
    'Query 3',
    'Query 4',
    // Add more queries as needed
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Dashboard",
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
            height: 300, // Set the height to 100 pixels
            child: PageView.builder(
              itemCount: queries.length,
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  selectedQueryIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                  child: Material(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Full screen width
                      color: Colors
                          .white, // Background color for the selected query
                      child: Center(
                        child: Text(
                          queries[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
