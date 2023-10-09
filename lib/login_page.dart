import 'package:boardingadmissions/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:boardingadmissions/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double opacityLevel = 0.0; // Initial opacity value

  @override
  void initState() {
    super.initState();
    // Delay the fade-in effect by a short duration
    Future.delayed(Duration(milliseconds: 300), _fadeIn);
  }

  void _fadeIn() {
    setState(() {
      opacityLevel = 1.0; // Set opacity to 1.0 for the fade-in effect
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        duration: Duration(seconds: 1), // Duration for the fade animation
        opacity: opacityLevel, // Use the animated opacity
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/logo.png'), // Replace with your image path
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(color: Color.fromARGB(0, 0, 0, 0)),
                      decoration: InputDecoration(hintText: 'Username'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(color: Color.fromARGB(0, 0, 0, 0)),
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle the "Forgot Password" action here.
                        // You can navigate to the password reset page or perform any other action.
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black87,
                      ),
                      child: Text('Forgot password'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                  // Your button click logic here
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0, // Adjust the radius as needed
                    ),
                  ),
                ),
                child: Container(
                  width: 200,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text("or login using"),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 30,
                width: 30,
                // decoration: BoxDecoration(color: Colors.blue),
                child: Image.asset(
                  'assets/googlelogo.png', // Correct image asset path
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text("Google"),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle the "Forgot Password" action here.
                      // You can navigate to the password reset page or perform any other action.
                    },
                    style: TextButton.styleFrom(),
                    child: const Text(
                      'New to boarding admissions?',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                  // Your button click logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white, // Make the button background transparent
                  onPrimary: Colors.blue, // Set text color to blue
                  side: const BorderSide(
                      color: Colors.blue, width: 2), // Add a blue border
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Rounded corners
                  ),
                ),
                child: Container(
                  width: 180,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


