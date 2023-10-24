import 'package:boardingadmissions/services/signup_service.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/login_page.dart';
import 'package:flutter/material.dart';




class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = '';
  String email = '';
  String selectedClass = '';
  List<String> selectedSchools = [];
  String location = '';
  String password = '';

  final List<String> schools = [
    'DIS',
    'ABC',
    'EDCFR',
    'SDF',
    'SDFSV',
    'DFSDFSVSDV',
  ];
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/logo.png',
                        height: 100,
                        width: 200,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          selectedClass = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Class',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Create a list of DropdownMenuItem for schools
                    DropdownButtonFormField<String>(
                      onChanged: (value) {
                        setState(() {
                          if (selectedSchools.contains(value)) {
                            selectedSchools.remove(value);
                          } else {
                            selectedSchools.add(value!);
                          }
                        });
                      },
                      items: schools.map((school) {
                        return DropdownMenuItem<String>(
                          value: school,
                          child: Text(school),
                        );
                      }).toList(),
                      hint: Text('Select School(s)'),
                      value: selectedSchools.isNotEmpty
                          ? selectedSchools[0]
                          : null,
                    ),
                    SizedBox(height: 20.0),
                    // Display selected schools as chips
                    Wrap(
                      spacing: 8.0,
                      runSpacing: -8.0,
                      children: selectedSchools.map((school) {
                        return InputChip(
                          label: Text(school),
                          onDeleted: () {
                            setState(() {
                              selectedSchools.remove(school);
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Location',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signup_service().registerUser(
                        name: name, // Pass the name value
                        email: email,
                        selectedClass: selectedClass, // Pass the email value
                        password: password,
                        location: location // Pass the password value
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Container(
                    width: 180,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                const Text("or login using"),
                SizedBox(
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
                SizedBox(
                  height: 3,
                ),
                const Text("Google"),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back_sharp)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: Text('Sign In'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}