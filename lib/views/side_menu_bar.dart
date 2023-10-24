import 'package:boardingadmissions/components/appbar.dart';
import 'package:boardingadmissions/models/sidemenu_assets.dart';
import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          // Adjust the margin to position it as needed
                          width: double.infinity,
                          height: 250,

                          color: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.work,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Circular Image (Upper)
                        Positioned(
                          left: 50,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Image.asset("assets/photos/image8.png"),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 220,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "HI",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "UserName",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 38,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "UserId",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            )),
                        // Rectangular Image (Lower)
                      ],
                    ),
                  ),
                ),
                Column(
                  children: sideMenuItems.map((asset) {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => asset['route']));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 60,
                              child: Icon(
                                asset[
                                    'icon'], // Use asset['icon'] to access the icon
                                key: Key(
                                  asset['key'],
                                ),
                                color: Colors
                                    .blue, // Provide a unique key for the Icon
                              ),
                            ),
                            Text(
                              asset['text'],
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ), // Use asset['text'] for the text
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            // Handle notifications icon press
                          },
                          icon: Icon(Icons.arrow_back_sharp),
                          label: Text("Back to Home")),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                      child: TextButton.icon(
                          onPressed: () async {
                            print(context.widget);
                            await AuthenticationServices().signOut();
                          },
                          icon: Icon(Icons.logout),
                          label: Text("Logout")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}