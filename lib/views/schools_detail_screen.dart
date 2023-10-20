import 'package:animated_menu/animated_menu.dart';
import 'package:boardingadmissions/components/side_menu_bar.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SchoolDetailPage extends StatefulWidget {
  @override
  _SchoolDetailPageState createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  1,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      GestureDetector(
                        onTap: () {
                          showAnimatedMenu(
                            context: context,
                            preferredAnchorPoint: Offset(
                              100, // X-coordinate, adjust as needed
                              100, // Y-coordinate, adjust as needed
                            ),
                            isDismissable: true,
                            useRootNavigator: true,
                            menu: AnimatedMenu(
                              items: [
                                FadeIn(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 170,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: const [
                                          SizedBox(height: 10),
                                          Text('Menu Item 1'),
                                          Divider(),
                                          Text('Menu Item 2'),
                                          Divider(),
                                          Text('Menu Item 3'),
                                          Divider(),
                                          Text('Menu Item 4'),
                                          Divider(),
                                          Text('Menu Item 5'),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                            color: Color.fromRGBO(2, 84, 152, 1),
                          ),
                          onPressed: () {
                            // Handle search icon press
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          size: 30,
                          color: Color.fromRGBO(2, 84, 152, 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuScreen(),
                            ),
                          );
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'school3.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'School Name',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'City, Country',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star_half, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Button 1',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Button 2',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Button 3',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Button 4',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              buildSeeMoreText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed pulvinar ligula ut est tincidunt, a bibendum tellus facilisis.',
                maxLines: 4,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Courses',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCourseCard('Course 1', '50px x 50px Card 1'),
                    buildCourseCard('Course 2', '50px x 50px Card 2'),
                    buildCourseCard('Course 3', '50px x 50px Card 3'),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              const Column(
                children: [
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Eligibility',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              buildSeeMoreText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed pulvinar ligula ut est tincidunt, a bibendum tellus facilisis.',
                maxLines: 4,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8.0),
              // Star Rating Widget
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_half, color: Colors.yellow),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                '5.0 (123 Reviews)',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              // Reviews Section
              buildReviewItem(
                'User 1',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                5,
              ),
              buildReviewItem(
                'User 2',
                'Sed pulvinar ligula ut est tincidunt, a bibendum tellus facilisis.',
                4,
              ),
              buildReviewItem(
                'User 3',
                'Praesent maximus sapien et quam ultricies, a bibendum tellus facilisis.',
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewItem(String userName, String reviewText, int rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star_half, color: Colors.yellow),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          '$rating/5',
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          userName,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          reviewText,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildSeeMoreText(String text, {int maxLines = 4}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: showFullText
                ? text
                : (text.length > maxLines * 35
                    ? text.substring(0, maxLines * 35) + '...'
                    : text),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            children: [
              if (text.length > maxLines * 35)
                TextSpan(
                  text: showFullText ? ' See Less' : ' See More',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        showFullText = !showFullText;
                      });
                    },
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildCourseCard(String courseName, String cardText) {
    return Container(
      alignment: Alignment.center,
      width: 120,
      height: 120,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          courseName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
