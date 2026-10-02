import 'package:flutter/material.dart';

import 'package:quiz_app/features/quiz/presentation/screens/quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final wrongAnswer = totalQuestions - score;

    final percentage = totalQuestions == 0
        ? 0
        : ((score / totalQuestions) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quize completed',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              Text(
                '$score / $totalQuestions',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 24,

                ),
              ),
              const SizedBox(height: 24,),

              Text('Correct Answer: $score'),
              Text('Worng Answer: $wrongAnswer'),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  child:const Text('Restart Quiz'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
