import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/design/colors.dart';
import 'package:medical_app/pages/document_upload_page.dart';

import '../data/data_user.dart';
import '../data/database_service.dart';
import '../data/document_data.dart';
import 'document_item.dart';


class MyDocumentPage extends StatelessWidget {
  final UserData currentUser;

  const MyDocumentPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _list(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: _button(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection("documents")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No documents found'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
          itemBuilder: (BuildContext context, int index) {
            final document = snapshot.data!.docs[index];
            final documentData = DocumentData.fromMap(document.data() as Map<String, dynamic>);
            return DocumentItem(
              title: documentData.title,
              content: documentData.content ?? '',
              dataS: documentData.dataS,
              dataF: documentData.dataF,
              state: documentData.state,
              documentId: document.id, // Передаем documentId в DocumentItem
            );
          },
        );
      },
    );
  }

  Widget _button(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary500,
        foregroundColor: primary900,
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
        minimumSize: const Size(200, 40),
        padding: const EdgeInsets.only(left: 35, right: 35),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DocumentUploadPage()),
        );
      },
      child: const Text(
        '+',
        style: TextStyle(
          color: primary50,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}