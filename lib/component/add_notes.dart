import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/component/loading_indicator.dart';
import 'package:mo_opendata_v2/component/response_message.dart';
import 'package:mo_opendata_v2/service/feedback_service.dart';

class AddNotes extends StatefulWidget {
  final int no;
  final TextEditingController notesController;
  // final FutureBuilder<Map<String, dynamic>> update;

  const AddNotes({
    Key? key,
    required this.no,
    required this.notesController,
    // required this.update,
  }) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  Future<Map<String, dynamic>> updateStatus({
    required int no,
    required String notes,
  }) async {
    var fs = FeedbackService();
    var result = await fs.updateStatus(no: no, notes: notes);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.only(bottom: 12, right: 12),
      title: const Text(
        'Add Notes',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: widget.notesController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 2,
          maxLines: 3,
          maxLength: 50,
          decoration: const InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Color(0xffF8F9FA),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: 32,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
        SizedBox(
          height: 32,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return update(context);
                  });
            },
            child: const Text('Submit'),
          ),
        )
      ],
    );
  }

  FutureBuilder<Map<String, dynamic>> update(BuildContext context) {
    return FutureBuilder(
      future: updateStatus(no: widget.no, notes: widget.notesController.text),
      builder: (context, snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = ResponseMessage(
              isOk: snapshot.data!['ok'],
              message: snapshot.data!['message'].toString());
        } else if (snapshot.hasError) {
          child = ResponseMessage(
              isOk: snapshot.data!['ok'],
              message: snapshot.data!['message'].toString());
        } else {
          child = const LoadingIndicator();
        }
        return Center(child: child);
      },
    );
  }
}
