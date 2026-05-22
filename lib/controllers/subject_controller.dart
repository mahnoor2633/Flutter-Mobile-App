// lib/controllers/subject_controller.dart
import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../services/api_service.dart';

class SubjectController extends ChangeNotifier {
  List<Subject> subjects = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchSubjects() async {
    try {
      isLoading = true;
      notifyListeners();
      subjects = await ApiService.fetchSubjects();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addSubject(Subject subject) async {
    final newSubject = await ApiService.createSubject(subject);
    subjects.add(newSubject);
    notifyListeners();
  }

  Future<void> updateSubject({
    required int index,
    required Subject subject,
  }) async {
    final updated = await ApiService.updateSubject(subject.id!, subject);
    subjects[index] = updated;
    notifyListeners();
  }

  Future<void> deleteSubject(int index) async {
    final id = subjects[index].id;
    await ApiService.deleteSubject(id!);
    subjects.removeAt(index);
    notifyListeners();
  }
}