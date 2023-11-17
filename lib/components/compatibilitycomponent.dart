import 'package:boardingadmissions/views/boardingcomp_loginscreen.dart';
import 'package:boardingadmissions/views/testtakingscreen.dart';
import 'package:flutter/material.dart';

class OptionsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionCard(
            title: 'Primary Option',
            color: Colors.blue,
          ),
          SizedBox(height: 16), // Adding some spacing between the cards
          OptionCard(
            title: 'Secondary Option',
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          OptionCard(
            title: 'Tertiary Option',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final Color color;

  OptionCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => testLoginPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 10,
          shadowColor: Colors.blue[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
