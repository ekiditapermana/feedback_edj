import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/component/add_notes.dart';
import 'package:mo_opendata_v2/component/feedback_detail.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';

class DetailScreen extends StatefulWidget {
  final FeedbackModel feedback;
  const DetailScreen({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _notesController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Feedback Detail'),
        actions: widget.feedback.status || widget.feedback.catatanMO.isEmpty
            ? null
            : [_popupMenuButton(context)],
      ),
      body: FeedbackDetail(feedback: widget.feedback),
    );
  }

  PopupMenuButton<int> _popupMenuButton(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        showDialog(
          context: context,
          builder: (context) => AddNotes(no: widget.feedback.no, notesController: _notesController),
        );
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: const EdgeInsets.all(8),
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.check,
                color: Colors.green,
              ),
              Text('Mark as Done'),
            ],
          ),
        ),
      ],
    );
  }
}
