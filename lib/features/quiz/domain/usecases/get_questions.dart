import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/domain/repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  const GetQuestions(this.repository);

  Future <List<Question>> call() {
    return repository.getQuestion();
  }
}
