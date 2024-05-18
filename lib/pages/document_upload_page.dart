import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../design/colors.dart';


import '../data/database_service.dart';
import '../design/styles.dart';

class DocumentUploadPage extends StatefulWidget {
  const DocumentUploadPage({super.key});

  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dataSController = TextEditingController();
  final TextEditingController _dataFController = TextEditingController();

  Future<void> _uploadDocument() async {
    if (_formKey.currentState!.validate()) {
      try {
        final docRef = FirebaseFirestore.instance.collection('users')
            .doc(currentUid) // Используем currentUid для получения ID текущего пользователя
            .collection('documents')
            .doc();

        await docRef.set({
          'title': _titleController.text,
          'content': _contentController.text,
          'state': true,
          'dataS': _dataSController.text,
          'dataF': _dataFController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Документ успешно загружен!')),
        );

        Navigator.pop(context); // Возвращаемся на предыдущую страницу
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки документа: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _dataSController.dispose();
    _dataFController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary500,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Загрузка документа',
          style: appbarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: customButtonStyle,
                onPressed: () {},
                child: const Text(
                  'Добавить документ',
                  style: textOnButtonStyle,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Название документа',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название документа';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Содержание документа',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dataSController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Дата выдачи документа',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите дату выдачи документа';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dataFController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Окончание действия документа',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: customButtonStyle,
                onPressed: _uploadDocument,
                child: const Text(
                  'Сохранить документ',
                  style: textOnButtonStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
