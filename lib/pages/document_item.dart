import 'package:flutter/material.dart';
import 'package:medical_app/design/colors.dart';

import '../data/database_service.dart';
import '../design/styles.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentItem extends StatefulWidget {
  final String title;
  final String content;
  final String dataS;
  final String? dataF;
  final bool state;
  final String documentId; // Добавим поле для идентификатора документа

  const DocumentItem({
    Key? key,
    required this.title,
    required this.content,
    required this.dataS,
    this.dataF,
    required this.state,
    required this.documentId, // Обновляем конструктор
  }) : super(key: key);

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Card(
            color: _isExpanded ? Colors.grey[300] : Colors.grey[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.state)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.autorenew,
                          color: Colors.orange,
                          size: 24.0,
                        ),
                      ),
                    if (widget.state)
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _confirmDelete(context);
                        },
                      ),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.content.isNotEmpty) ...[
                  Text(
                    widget.content,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
                if (widget.dataS.isNotEmpty) ...[
                  Text(
                    'Дата начала: ${widget.dataS}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
                if (widget.dataF != null && widget.dataF!.isNotEmpty) ...[
                  Text(
                    'Дата окончания: ${widget.dataF}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
                if (widget.content.isEmpty && widget.dataS.isEmpty && (widget.dataF == null || widget.dataF!.isEmpty)) ...[
                  Text(
                    'Нет информации',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
                SizedBox(height: 20),
              ],
            ),
          ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Подтвердите удаление"),
          content: Text("Вы уверены, что хотите удалить данный документ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                _deleteDocument();
                Navigator.of(context).pop();
              },
              child: Text(
                "Удалить",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteDocument() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection("documents")
        .doc(widget.documentId)
        .delete()
        .then((value) {
      print("Document successfully deleted!");
    }).catchError((error) {
      print("Error removing document: $error");
    });
  }
}
