import 'package:boardingadmissions/hamburger_screen.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState(); // Corrected the state class name
}

class _MyAppBarState extends State<MyAppBar> { // Corrected the state class name
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
    );
  }
}
