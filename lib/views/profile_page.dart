import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/components/notes_cards.dart';
import 'package:boardingadmissions/views/studymaterial_page.dart';
import 'package:flutter/material.dart';
import 'package:boardingadmissions/components/dashboard.dart';
import 'package:boardingadmissions/components/achivementsComponent.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
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
                        'assets/bgimage.png', // Replace with your background image URL
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
                            'assets/school2.png', // Replace with your profile image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: const Row(
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudyMaterial()));
                                },
                                icon: const Icon(Icons.note_add_outlined),
                                color: Colors.blue,
                                iconSize: 25,
                                alignment: Alignment.centerRight,
                              ),
                              const Text("Notes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 8,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.bookmark_add_outlined,
                                ),
                                color: Colors.blue,
                                iconSize: 25,
                                alignment: Alignment.centerRight,
                              ),
                              const Text("Bookmarks",
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
              AchievementsComponent(),
              Dashboard(),
            ],
          ),
        ]),
      ),
    );
  }
}
