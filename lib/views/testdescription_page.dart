import 'package:boardingadmissions/components/compatibiltyappbar.dart';
import 'package:boardingadmissions/views/testtakingscreen.dart';
import 'package:flutter/material.dart';

class TestDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CompatibilityTestAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Test Name: Boarding Admissions Compatibilty Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Number of Questions: 20',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Test Duration: 15 minutes',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'This test is designed to assess your knowledge in psychology. '
              'Make sure you have a quiet environment to concentrate during the test.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Read each question carefully before selecting your answer.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Read each question carefully before selecting your answer.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '2. Choose the option that best corresponds to your understanding of the topic.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '3. You will have a total of 20 minutes to complete the test.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '4. Avoid spending too much time on a single question.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Good luck! Click the "Take Test"',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to the test-taking screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestTakingScreen(
  
                    ),
                  ),
                );
              },
              child: Text('Take Test'),
            ),
          ],
        ),
      ),
    );
  }
}
