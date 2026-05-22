// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subject.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // GET
  static Future<List<Subject>> fetchSubjects() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Subject.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // POST
  static Future<Subject> createSubject(Subject subject) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(subject.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return Subject.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create');
    }
  }

  // PUT
  static Future<Subject> updateSubject(int id, Subject subject) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      body: jsonEncode(subject.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Subject.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  // DELETE
  static Future<void> deleteSubject(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete');
    }
  }
}