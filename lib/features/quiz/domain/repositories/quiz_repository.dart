import 'package:quiz_app/features/quiz/domain/entities/question.dart';

abstract class QuizRepository {
 Future <List<Question>> getQuestion();
}
