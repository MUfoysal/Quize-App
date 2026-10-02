import 'package:quiz_app/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:quiz_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_app/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  const QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Question>> getQuestion() async {
    final model = await remoteDataSource.getQuestions();

    return model.map((model) => model.toEntity()).toList();
  }
}
