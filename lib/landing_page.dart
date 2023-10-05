import 'package:flutter/material.dart';
import 'package:boardingadmissions/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('logo.png'),
              height: 100,
              width: 400,
            ),
            const SizedBox(height: 10),
           const TextField(
              style: TextStyle(color: Color.fromARGB(0, 0, 0, 0)),
              decoration: InputDecoration(hintText: 'Username'),
            ),
             const SizedBox(height: 10),
            const TextField(
              style: TextStyle(color: Color.fromARGB(0, 0, 0, 0)),
              decoration: InputDecoration(hintText: 'Password'),
            ),
            const  SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: const TextSpan(text: 'Forgot password'),
                  selectionRegistrar: SelectionContainer.maybeOf(context),
                  selectionColor: const Color(0xAF6694e8),
                ),
              ],
            ),
            const  SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage()), // Replace with your destination page
                );
                // Your button click logic here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                ),
              ),
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      // You can add your widgets and content here.
    );
  }
}
