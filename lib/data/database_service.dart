import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_user.dart';
import 'document_data.dart';
import 'events_data.dart';

String currentUid = '';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late UserData _userData;
  late List<EventData> _events; // добавлено поле для хранения событий

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  CollectionReference get _userCollection =>
      FirebaseFirestore.instance.collection('users');

  CollectionReference get _eventCollection =>
      FirebaseFirestore.instance.collection('events');

  Future<void> getUserDataByUid(String uid) async {
    try {
      print("1");
      DocumentSnapshot<Object?> snapshot = await _userCollection.doc(uid).get();
      print("2");
      if (snapshot.exists) {
        print("3");
        _userData = UserData.fromFirestore(snapshot);
        print("4");
        await getUserDocuments(uid);
        print("5");
      } else {
        throw Exception("User with UID $uid not found");
      }
    } catch (e) {
      print("Error getting user data: $e");
      rethrow;
    }
  }


  Future<void> getUserDocuments(String uid) async {
    try {
      print("6");
      List<DocumentData> documents = [];

      // Получаем все документы из коллекции 'documents'
      QuerySnapshot snapshot = await _userCollection.doc(uid).collection("documents").get();

      print("7");
      for (var document in snapshot.docs) {
        print("8");
        documents.add(DocumentData.fromMap(document.data() as Map<String, dynamic>));
      }

      print("9");
      _userData.documents = documents;
    } catch (e) {
      print("Error getting document data: $e");
      rethrow;
    }
  }

  Future<void> getEventsByCourse(String? course) async {
    print("21");
    try {
      print("22");
      if (course == null) return;

      QuerySnapshot snapshot = await _eventCollection.where('courses', arrayContains: int.parse(course)).get();
      _events = snapshot.docs.map((doc) => EventData.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error getting event data: $e");
      rethrow;
    }
  }

  UserData get userData => _userData;
  List<EventData> get events => _events;
}