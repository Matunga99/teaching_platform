import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/assignment.dart';

class AssignmentNotifier extends StateNotifier<List<Assignment>> {
  late SharedPreferences _prefs;

  AssignmentNotifier() : super([]) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadAssignments();
  }

  Future<void> loadAssignments() async {
    try {
      final assignmentsJson = _prefs.getStringList('assignments') ?? [];
      final assignments = assignmentsJson
          .map((json) => Assignment.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      state = assignments;
    } catch (e) {
      print('Error loading assignments: $e');
    }
  }

  Future<void> addAssignment(Assignment assignment) async {
    try {
      final assignments = [...state, assignment];
      final assignmentsJson = assignments.map((a) => jsonEncode(a.toJson())).toList();
      await _prefs.setStringList('assignments', assignmentsJson);
      state = assignments;
    } catch (e) {
      print('Error adding assignment: $e');
    }
  }

  Future<void> submitAssignment(String assignmentId, String content) async {
    try {
      final assignments = state.map((a) {
        if (a.id == assignmentId) {
          return Assignment(
            id: a.id,
            courseId: a.courseId,
            title: a.title,
            description: a.description,
            instructions: a.instructions,
            dueDate: a.dueDate,
            pointsTotal: a.pointsTotal,
            createdAt: a.createdAt,
            submissionType: a.submissionType,
            isSubmitted: true,
            submissionContent: content,
            submittedAt: DateTime.now(),
          );
        }
        return a;
      }).toList();
      final assignmentsJson = assignments.map((a) => jsonEncode(a.toJson())).toList();
      await _prefs.setStringList('assignments', assignmentsJson);
      state = assignments;
    } catch (e) {
      print('Error submitting assignment: $e');
    }
  }

  List<Assignment> getPendingAssignments() {
    return state.where((a) => !a.isSubmitted && a.dueDate.isAfter(DateTime.now())).toList();
  }
}

final assignmentProvider =
    StateNotifierProvider<AssignmentNotifier, List<Assignment>>((ref) {
  return AssignmentNotifier();
});
