
import 'package:flutter/material.dart';

import 'package:quiz_app/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:quiz_app/features/home/presentation/screens/home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  final int score;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final wrongAnswers = totalQuestions - score;

    final percentage = totalQuestions == 0
        ? 0
        : ((score / totalQuestions) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.indigo,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        size: 42,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Quiz Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '$score / $totalQuestions',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green.shade600,
                              size: 28,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              '$score',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text('Correct'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cancel_rounded,
                              color: Colors.red.shade600,
                              size: 28,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              '$wrongAnswers',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text('Wrong'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.replay_rounded),
                    label: const Text(
                      'Restart Quiz',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home_rounded),
                    label: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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
