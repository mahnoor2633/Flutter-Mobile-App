// lib/models/subject.dart
class Subject {
  final int? id;
  final String title;
  final String body;

  Subject({
    this.id,
    required this.title,
    required this.body,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}