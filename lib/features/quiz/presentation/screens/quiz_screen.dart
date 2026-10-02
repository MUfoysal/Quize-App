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
    try {
      final questions = await _getQuestions();

      if (!mounted) return;

      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _errorMessage = error.toString();
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

  void _goTonextQuestion() {
    final question = _questions[_currentQuestionIndex];

    if (_selectedAnswerIndex == question.correctAnswerIndex) {
      _score++;
    }
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    if (isLastQuestion) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(score: _score, totalQuestions: _questions.length),
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_errorMessage != null) {
      return Scaffold(body: Center(child: Text(_errorMessage!)));
    }

    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No question available.')),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${_currentQuestionIndex + 1}/${_questions.length}',
        ),
      ),
      body:Column(
        children: [
          LinearProgressIndicator(
            value: (_currentQuestionIndex +1) / _questions.length,
          ),
        
      
      
      Expanded(child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            ...List.generate(question.options.length, (index) {
              final option = question.options[index];

              final isSelected = _selectedAnswerIndex == index;
              final isCorrect = question.correctAnswerIndex == index;
              final isWrong = _hasAnswered && isSelected && !isCorrect;

              Color borderColor = Colors.grey.shade300;
              Color backgroundColor = Colors.white;

              if (_hasAnswered && isCorrect) {
                borderColor = Colors.green;
                backgroundColor = Colors.green.shade50;
              } else if (isWrong) {
                borderColor = Colors.red;
                backgroundColor = Colors.red.shade50;
              } else if (isSelected) {
                borderColor = Colors.blue;
                backgroundColor = Colors.blue.shade50;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _selectAnswer(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      color: backgroundColor,
                    ),
                    child: Text(option, style: const TextStyle(fontSize: 16)),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAnswerIndex == null
                    ? null
                    : _goTonextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedAnswerIndex == null
                      ? Colors.grey
                      : Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      )
        
      )
      ]
      ),
    );
  }
}
