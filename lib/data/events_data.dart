
import 'package:cloud_firestore/cloud_firestore.dart';

class EventData {
  final String title;
  final String content;
  final List<int> courses;

  EventData({
    required this.title,
    required this.content,
    required this.courses,
  });

  factory EventData.fromMap(Map<String, dynamic> map) {
    return EventData(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      courses: List<int>.from(map['courses'] ?? []),
    );
  }
}