import 'package:cloud_firestore/cloud_firestore.dart';

import 'document_data.dart';

class UserData {
  final String firstName;
  final String lastName;
  final String? fatherName;
  final String? birthday;
  final String? group;
  final String? course;
  final String? photoUrl; // Новое поле для URL изображения
  List<DocumentData> documents;

  UserData({
    required this.firstName,
    required this.lastName,
    this.fatherName,
    this.birthday,
    this.group,
    this.course,
    this.photoUrl, // Инициализация нового поля
    required this.documents,
  });

  factory UserData.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    List<DocumentData> documents = [];
    if (data['documents'] != null) {
      documents = List<DocumentData>.from(
        data['documents'].map((doc) => DocumentData.fromMap(doc)),
      );
    }

    return UserData(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      fatherName: data['fatherName'],
      birthday: data['birthday'],
      group: data['group'],
      course: data['course'],
      photoUrl: data['photoUrl'], // Получение значения из Firestore
      documents: documents,
    );
  }
}





