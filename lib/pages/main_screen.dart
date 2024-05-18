import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/settings_page.dart';
import 'package:medical_app/pages/testBD.dart';

import '../data/data_user.dart';
import '../data/database_service.dart';
import '../data/events_data.dart';
import '../design/styles.dart';
import 'events_page.dart';
import 'my_documents_page.dart';
import '../../design/colors.dart';
import 'profile_page.dart';
import 'testBD.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData currentUser = DatabaseService().userData;
    List<EventData> currentevents = DatabaseService().events;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary500,
          title: const Text(
            'Главная страница',
            style: appbarTextStyle,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
          automaticallyImplyLeading: false,
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return primary600.withOpacity(0.5);
                }
                return Colors.transparent;
              },
            ),
            unselectedLabelColor: primary200,
            labelStyle: TextStyle(
              color: primary50,
            ),
            tabs: const [
              Tab(text: '  ПРОФИЛЬ  '),
              Tab(text: ' ДОКУМЕНТЫ '),
              Tab(text: 'МЕРОПРИЯТИЯ'),
            ],
            indicator: BoxDecoration(
              color: primary600,
              borderRadius: BorderRadius.circular(5),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: TabBarView(
          children: [
            ProfilePage(currentUser: currentUser),
            MyDocumentPage(currentUser: currentUser),
            EventsPage(currentEvents: currentevents),
          ],
        ),
      ),
    );
  }
}
