import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  int selectedQueryIndex = 0;

  final List<String> queries = [
    'Q 1',
    'Q 2',
    'Q 3',
    'Q 4',
    // Add more queries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the radius as needed
                    child: Image.asset(
                      'bgimage.png', // Replace with your background image URL
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      color: Colors.black
                          .withOpacity(0.5), // Set the opacity of the image
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  // Profile image in front of the background image
                  Positioned(
                    bottom: 20, // Adjust the positioning as needed
                    left: 20, // Adjust the positioning as needed
                    child: Container(
                      width: 60, // Set the width of the profile image
                      height: 60, // Set the height of the profile image
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'school2.png', // Replace with your profile image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Class 9",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Delhi",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Cool.KID",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.note_add_outlined),
                              color: Colors.blue,
                              iconSize: 25,
                              alignment: Alignment.centerRight,
                            ),
                            Text("Notes",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_add_outlined,
                              ),
                              color: Colors.blue,
                              iconSize: 25,
                              alignment: Alignment.centerRight,
                            ),
                            Text("Bookmarks",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8,
                                  color: Colors.blue,
                                ))
                          ],
                        )
                      ],
                    ),
                  )
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Achievements",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.blue,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shadowColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                ),
                                Text(
                                  "Weekly\nWinners",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shadowColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.badge_rounded),
                                SizedBox(width: 5),
                                Text(
                                  "Weekly\nWinners",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black45,
                                shadowColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.abc),
                                Text(
                                  "Weekly\nWinners",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text("Unlock More",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.blue,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shadowColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                ),
                                Text(
                                  "Weekly\nWinners",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shadowColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.badge_rounded),
                                SizedBox(width: 5),
                                Text(
                                  "Weekly\nWinners",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black45,
                                shadowColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.abc),
                                Text(
                                  "Weekly\nWinners",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
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
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      children: [
                        buildQueryButton("Query 1", 0),
                        SizedBox(
                          width: 10,
                        ),
                        buildQueryButton("Query 2", 1),
                        SizedBox(
                          width: 10,
                        ),
                        buildQueryButton("Query 3", 2),
                        SizedBox(
                          width: 10,
                        ),
                        buildQueryButton("Query 4", 3),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300, // Set the height to 100 pixels
                    child: PageView.builder(
                      itemCount: queries.length,
                      controller: PageController(
                        initialPage: selectedQueryIndex, // Set the initial page
                        viewportFraction: 1.0, // Display one page at a time
                        keepPage: false, // Do not keep pages in memory
                      ),
                      onPageChanged: (int index) {
                        setState(() {
                          selectedQueryIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context)
                                .size
                                .width, // Full screen width
                            color: Colors
                                .greenAccent, // Background color for the selected query
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
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [],
                  )
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }

  ElevatedButton buildQueryButton(String text, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: selectedQueryIndex == index ? 2 : 0,
      ),
      onPressed: () {
        setState(() {
          selectedQueryIndex = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.blue),
      ),
    );
  }
}
