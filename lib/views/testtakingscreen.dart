import 'dart:async';
import 'package:boardingadmissions/models/compatilbilitytest_model.dart';
import 'package:boardingadmissions/views/bct_resultscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boardingadmissions/views/home_page.dart';

class TestTakingScreen extends StatefulWidget {
  @override
  _TestTakingScreenState createState() => _TestTakingScreenState();
}

class _TestTakingScreenState extends State<TestTakingScreen> {
  late SharedPreferences _prefs;
  int _remainingTime = 12000;
  late Timer _timer;
  bool _isPaused = false;
  int _currentQuestionIndex = 0;
  String? selectedOption;
  Map<int, String?> userResponses = {};

  @override
  void initState() {
    super.initState();
    _initPrefs();

    _startTimer();
  }

  List<Map<String, dynamic>> selectedOptionsList = [];

  void _nextQuestion() {
    if (selectedOption != null) {
      selectedOptionsList.add({
        'question': psychologicalQuestions[_currentQuestionIndex]['question'],
        'selectedOption': selectedOption,
      });
    }

    if (_currentQuestionIndex < psychologicalQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        selectedOption = null;
      });
    } else {
      int totalWeightage = _calculateTotalWeightage();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(totalWeightage: totalWeightage),
        ),
      );
    }
  }

  int _calculateTotalWeightage() {
    int totalWeightage = 0;
    for (var selectedOption in selectedOptionsList) {
      int weightage = psychologicalQuestions.firstWhere(
        (question) => question['question'] == selectedOption['question'],
      )['options'][selectedOption['selectedOption']];
      totalWeightage += weightage;
    }
    return totalWeightage;
  }
Future<void> _initPrefs() async {
  _prefs = await SharedPreferences.getInstance();
  _loadRemainingTime();
  _loadUserResponses();
  _loadCurrentQuestionIndex(); // Add this line
}


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0 && !_isPaused) {
        setState(() {
          _remainingTime--;
          _saveRemainingTime();
        });
      } else {
        _timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }
void _pauseTimer() {
  setState(() {
    _isPaused = true;
    userResponses[_currentQuestionIndex] = selectedOption;
    _saveRemainingTime();
    _saveUserResponses();
    _saveCurrentQuestionIndex();
  });
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}
void _loadCurrentQuestionIndex() {
  setState(() {
    _currentQuestionIndex = _prefs.getInt('currentQuestionIndex') ?? 0;
  });
}


void _saveCurrentQuestionIndex() {
  _prefs.setInt('currentQuestionIndex', _currentQuestionIndex);
}

  void _loadUserResponses() {
    for (int i = 0; i < psychologicalQuestions.length; i++) {
      String? response = _prefs.getString('$i');
      if (response != null) {
        userResponses[i] = response;
        if (_currentQuestionIndex == i) {
          selectedOption = response;
        }
      }
    }
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
    });
    _startTimer();
  }

  void _loadRemainingTime() {
    setState(() {
      _remainingTime = _prefs.getInt('remainingTime') ?? _remainingTime;
    });
  }

  void _saveRemainingTime() {
    _prefs.setInt('remainingTime', _remainingTime);
  }

  void onOptionSelected(String value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Remaining Time: $_remainingTime seconds'),
            SizedBox(height: 20),
            PauseButton(
              isPaused: _isPaused,
              onPause: _pauseTimer,
              onResume: _resumeTimer,
            ),
            SizedBox(height: 20),
            QuestionWidget(
              questionNumber:
                  _currentQuestionIndex + 1, // Add 1 to make it 1-based
              question: psychologicalQuestions[_currentQuestionIndex]
                  ['question'],
              options: psychologicalQuestions[_currentQuestionIndex]['options'],
              selectedOption: selectedOption,
              onOptionSelected: onOptionSelected,
            ),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text('Next Question'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveUserResponses() {
    // Save user responses when pausing or finishing the test
    userResponses.forEach((index, response) {
      _prefs.setString('$index', response ?? '');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    _saveUserResponses();
  }
}

class QuestionWidget extends StatelessWidget {
  final int questionNumber;
  final String question;
  final Map<String, dynamic> options;
  final String? selectedOption;
  final ValueChanged<String> onOptionSelected;

  QuestionWidget({
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Question $questionNumber: $question'),
        for (var option in options.keys)
          RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedOption,
            onChanged: (value) {
              onOptionSelected(value!);
            },
          ),
      ],
    );
  }
}

class PauseButton extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onPause;
  final VoidCallback onResume;

  PauseButton({
    required this.isPaused,
    required this.onPause,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            onPause();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text('Pause'),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
