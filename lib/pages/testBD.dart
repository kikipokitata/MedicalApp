
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/data_user.dart';
import '../pages/login_screen.dart';

class Test extends StatelessWidget {


  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Имя пользователяНет данных'),

    );
  }
}
//
// class TestBD extends StatelessWidget {
//   final UserData? userData;
//
//   const TestBD({Key? key, this.userData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot<Object?>>(
//       future: docRef.get(),
//       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Ошибка: ${snapshot.error}');
//         }
//         final data = snapshot.data!.data() as Map<String, dynamic>;
//         user = UserData(
//           firstName: data['firstName'] ?? '',
//           lastName: data['lastName'] ?? '',
//           fatherName: data['fatherName'],
//         );
//         return Container(
//           child: Text(userDataList[index].firstName), // Отображаем данные пользователя
//         );
//       },
//     );
//   }
// }

