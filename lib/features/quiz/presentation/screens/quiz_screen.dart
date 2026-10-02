import 'package:flutter/material.dart';

import 'package:quiz_app/features/quiz/data/di/quiz_dependencies.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/domain/usecases/get_questions.dart';

class QuizScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final GetQuestions _getQuestions;

  List<Question> _questions = [];
  bool _isLoading = true;
  String? _errorMessage;

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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_errorMessage != null) {
      return Scaffold(body: Center(child: Text(_errorMessage!)));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quize"),
      ),

      body: Center(
        child: Text(
          'Question loaded: ${_questions.length}',

        ),
      ),
    );
  }
}
