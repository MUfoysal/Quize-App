import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:quiz_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:quiz_app/features/quiz/domain/usecases/get_questions.dart';

GetQuestions createGetQuestions() {
  final firestore = FirebaseFirestore.instance;

  final remoteDataSource = QuizRemoteDataSource(firestore);

  final repository = QuizRepositoryImpl(remoteDataSource);

  return GetQuestions(repository);
}