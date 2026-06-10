import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/course.dart';

class CourseNotifier extends StateNotifier<List<Course>> {
  late SharedPreferences _prefs;

  CourseNotifier() : super([]) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      final coursesJson = _prefs.getStringList('courses') ?? [];
      final courses = coursesJson
          .map((json) => Course.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      state = courses;
    } catch (e) {
      print('Error loading courses: $e');
    }
  }

  Future<void> addCourse(Course course) async {
    try {
      final courses = [...state, course];
      final coursesJson = courses.map((c) => jsonEncode(c.toJson())).toList();
      await _prefs.setStringList('courses', coursesJson);
      state = courses;
    } catch (e) {
      print('Error adding course: $e');
    }
  }

  Future<void> updateCourse(Course course) async {
    try {
      final courses = state.map((c) => c.id == course.id ? course : c).toList();
      final coursesJson = courses.map((c) => jsonEncode(c.toJson())).toList();
      await _prefs.setStringList('courses', coursesJson);
      state = courses;
    } catch (e) {
      print('Error updating course: $e');
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      final courses = state.where((c) => c.id != courseId).toList();
      final coursesJson = courses.map((c) => jsonEncode(c.toJson())).toList();
      await _prefs.setStringList('courses', coursesJson);
      state = courses;
    } catch (e) {
      print('Error deleting course: $e');
    }
  }
}

final courseProvider =
    StateNotifierProvider<CourseNotifier, List<Course>>((ref) {
  return CourseNotifier();
});
