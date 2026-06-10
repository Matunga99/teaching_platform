import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quiz.dart';

class QuizNotifier extends StateNotifier<List<Quiz>> {
  late SharedPreferences _prefs;

  QuizNotifier() : super([]) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadQuizzes();
  }

  Future<void> loadQuizzes() async {
    try {
      final quizzesJson = _prefs.getStringList('quizzes') ?? [];
      final quizzes = quizzesJson
          .map((json) => Quiz.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      state = quizzes;
    } catch (e) {
      print('Error loading quizzes: $e');
    }
  }

  Future<void> addQuiz(Quiz quiz) async {
    try {
      final quizzes = [...state, quiz];
      final quizzesJson = quizzes.map((q) => jsonEncode(q.toJson())).toList();
      await _prefs.setStringList('quizzes', quizzesJson);
      state = quizzes;
    } catch (e) {
      print('Error adding quiz: $e');
    }
  }

  Future<void> submitQuiz(String quizId, int score) async {
    try {
      final quizzes = state.map((q) {
        if (q.id == quizId) {
          return Quiz(
            id: q.id,
            courseId: q.courseId,
            title: q.title,
            description: q.description,
            questions: q.questions,
            passingScore: q.passingScore,
            createdAt: q.createdAt,
            isTaken: true,
            score: score,
            takenAt: DateTime.now(),
            timeLimit: q.timeLimit,
          );
        }
        return q;
      }).toList();
      final quizzesJson = quizzes.map((q) => jsonEncode(q.toJson())).toList();
      await _prefs.setStringList('quizzes', quizzesJson);
      state = quizzes;
    } catch (e) {
      print('Error submitting quiz: $e');
    }
  }

  List<Quiz> getAvailableQuizzes() {
    return state.where((q) => !q.isTaken).toList();
  }
}

final quizProvider =
    StateNotifierProvider<QuizNotifier, List<Quiz>>((ref) {
  return QuizNotifier();
});

final availableQuizzesProvider = Provider<List<Quiz>>((ref) {
  final quizzes = ref.watch(quizProvider);
  return quizzes.where((q) => !q.isTaken).toList();
});
