import 'package:flutter/material.dart';
import '../../design/colors.dart';
import '../data/events_data.dart';

class EventItem extends StatefulWidget {
  final EventData event;

  const EventItem({Key? key, required this.event}) : super(key: key);

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary300,
      elevation: 0.06,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _title(),
              if (_isExpanded) ...[
                SizedBox(height: 10),
                _formattedContent(widget.event.content),

              ],
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Свернуть' : 'Читать далее...',
                  style: TextStyle(color: primary500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        widget.event.title,
        style: TextStyle(
          color: primary900,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _formattedContent(String content) {
    String formattedContent = content.replaceAll('\\n', '\n');

    return Text(
      formattedContent,
      style: TextStyle(
        color: primary900,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
