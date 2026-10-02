import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';

class QuizRemoteDataSource {
  final FirebaseFirestore firestore;

  const QuizRemoteDataSource(this.firestore);

  Future<List<QuestionModel>> getQuestions() async {
    final snapshot = await firestore.collection('questions').get();

    return snapshot.docs
        .map((doc) => QuestionModel.fromMap(doc.data()))
        .toList();
  }
}
