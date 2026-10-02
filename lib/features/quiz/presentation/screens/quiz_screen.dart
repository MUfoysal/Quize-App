
import 'package:flutter/material.dart';

import 'package:quiz_app/features/result/presentation/screens/result_screen.dart';
import 'package:quiz_app/features/quiz/data/di/quiz_dependencies.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/domain/usecases/get_questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final GetQuestions _getQuestions;

  List<Question> _questions = [];

  bool _isLoading = true;

  String? _errorMessage;

  int _currentQuestionIndex = 0;

  int? _selectedAnswerIndex;

  int _score = 0;

  bool _hasAnswered = false;

  @override
  void initState() {
    super.initState();

    _getQuestions = createGetQuestions();

    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final questions = await _getQuestions();

      if (!mounted) return;

      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Failed to load questions. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _selectAnswer(int index) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswerIndex = index;
      _hasAnswered = true;
    });
  }

  void _goToNextQuestion() {
    final question = _questions[_currentQuestionIndex];

    if (_selectedAnswerIndex == question.correctAnswerIndex) {
      _score++;
    }

    final isLastQuestion =
        _currentQuestionIndex == _questions.length - 1;

    if (isLastQuestion) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: _questions.length,
          ),
        ),
      );

      return;
    }

    setState(() {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      _hasAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  size: 56,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loadQuestions,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No questions available.'),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];

    final totalQuestions = _questions.length;

    final questionNumber = _currentQuestionIndex + 1;

    final isLastQuestion =
        _currentQuestionIndex == totalQuestions - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question $questionNumber of $totalQuestions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: questionNumber / totalQuestions,
                minHeight: 8,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    for (var i = 0; i < question.options.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: _hasAnswered
                              ? null
                              : () => _selectAnswer(i),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _getOptionBackgroundColor(
                                question,
                                i,
                              ),
                              border: Border.all(
                                color: _getOptionBorderColor(
                                  question,
                                  i,
                                ),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _getOptionBadgeColor(
                                      question,
                                      i,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    String.fromCharCode(65 + i),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    question.options[i],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _hasAnswered
                      ? _goToNextQuestion
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    isLastQuestion ? 'Finish' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getOptionBackgroundColor(
    Question question,
    int index,
  ) {
    if (!_hasAnswered) {
      return Colors.white;
    }

    if (index == question.correctAnswerIndex) {
      return Colors.green.shade50;
    }

    if (index == _selectedAnswerIndex) {
      return Colors.red.shade50;
    }

    return Colors.white;
  }

  Color _getOptionBorderColor(
    Question question,
    int index,
  ) {
    if (!_hasAnswered) {
      return Colors.grey.shade300;
    }

    if (index == question.correctAnswerIndex) {
      return Colors.green;
    }

    if (index == _selectedAnswerIndex) {
      return Colors.red;
    }

    return Colors.grey.shade300;
  }

  Color _getOptionBadgeColor(
    Question question,
    int index,
  ) {
    if (!_hasAnswered) {
      return Colors.blue;
    }

    if (index == question.correctAnswerIndex) {
      return Colors.green;
    }

    if (index == _selectedAnswerIndex) {
      return Colors.red;
    }

    return Colors.blue;
  }
}
