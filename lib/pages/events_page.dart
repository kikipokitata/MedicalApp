import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/database_service.dart';
import '../data/events_data.dart';
import 'events_items.dart';


class EventsPage extends StatelessWidget {
  final List<EventData> currentEvents;

  const EventsPage({Key? key, required this.currentEvents}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _list(),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.separated(
      itemCount: currentEvents.length,
      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (BuildContext context, int index) {
        return EventItem(event: currentEvents[index]);
      },
    );
  }
}