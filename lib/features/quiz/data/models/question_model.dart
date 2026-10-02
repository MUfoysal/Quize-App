import '../../domain/entities/question.dart';

class QuestionModel {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  const QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] as String,
      options: List<String>.from(map['options'] as List),
      correctAnswerIndex: map['correctAnswerIndex'] as int,
    );
  }

  Question toEntity() {
    return Question(
      question: question,
      options: options,
      correctAnswerIndex: correctAnswerIndex,
    );
  }
}