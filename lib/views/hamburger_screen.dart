import 'package:boardingadmissions/views/home_page.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  double menuWidth = 0.0;

  @override
  void initState() {
    super.initState();
    // Add a delay to start the animation after the widget is built
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        menuWidth = double.infinity; // Set your desired menu width here
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content behind the menu
        Container(
          color: Colors.white.withOpacity(0.8), // Use your background color
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the menu
              },
              child: Text('Close Menu'),
            ),
          ),
        ),

        // Sliding menu
        AnimatedContainer(
          duration:
              Duration(milliseconds: 300), // Adjust the duration as needed
          width: menuWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.8),
              ],
              stops: const [
                0.0,
                0.1,
              ],
            ),
          ),
          child: Column(
            children: [
              // App bar
              AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 50,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.8),
                      ],
                      stops: const [
                        0.0,
                        0.1,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_left,
                              size: 30, color: Color.fromRGBO(2, 84, 152, 1)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            // Handle notifications icon press
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Image.asset(
                          'assets/logo.png',
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
                                  size: 30,
                                  color: Color.fromRGBO(2, 84, 152, 1)),
                              onPressed: () {
                                // Handle search icon press
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu,
                                  size: 30,
                                  color: Color.fromRGBO(2, 84, 152, 1)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuScreen()));
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

              // Menu items
              Expanded(
                child: Material(
                  child: ListView(
                    children: [
                      SizedBox(height: 30), // Increase the gap at the top
                      ListTile(
                        title: Text('Home',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700)),
                        onTap: () {
                          // Handle navigation to Home screen
                          Navigator.pop(context); // Close the menu
                        },
                      ),
                      SizedBox(height: 20), // Increase the gap between items
                      ListTile(
                        title: Text('Profile',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700)),
                        onTap: () {
                          // Handle navigation to Profile screen
                          Navigator.pop(context); // Close the menu
                        },
                      ),
                      // Add more ListTile items for other menu options
                      SizedBox(height: 20), // Increase the gap between items
                      Divider(
                        color: Colors.blue,
                        thickness: 0.5,
                      ),
                      SizedBox(
                          height:
                              20), // Increase the gap before the "Back to Home" item
                      ListTile(
                        title: Text('Back to Home',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700)),
                        onTap: () {
                          // Handle navigation back to the Home page
                          Navigator.pop(context); // Close the menu
                          Navigator.pop(
                              context); // Close the MenuScreen and return to HomePage
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
