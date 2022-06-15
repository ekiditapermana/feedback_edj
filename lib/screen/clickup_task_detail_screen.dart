import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/clickup_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class TaskDetail extends StatefulWidget {
  final Subtask task;
  final List<Attachment> attachments;
  const TaskDetail({
    Key? key,
    required this.task,
    required this.attachments,
  }) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final List<Map<String, dynamic>> _users = [
    {
      "id": 1,
      "name": "Muhammad Iqbal Ali",
      "clickup_id": 5983695,
      "telegram_username": "@iqbalali167",
    },
    {
      "id": 2,
      "name": "Arifatus Hikmah Rusmanasari",
      "clickup_id": 5830458,
      "telegram_username": "@arifatus",
    },
    {
      "id": 3,
      "name": "Nia Karuniawati Solihah",
      "clickup_id": 5830449,
      "telegram_username": "@Nia_ks",
    },
    {
      "id": 4,
      "name": "Nurul Nur Annisa",
      "clickup_id": 5826312,
      "telegram_username": "@annisann111",
    },
    {
      "id": 5,
      "name": "Rima Sapitri",
      "clickup_id": 5934693,
      "telegram_username": "@rima127",
    },
  ];

  List contributors = [];

  String _content = '';

  File? _displayImage;

  Future<void> _download() async {
    String url = widget.attachments[0].url;
    final response = await http.get(Uri.parse(url));

    // Get the image name
    final imageName = path.basename(url);
    // Get the document directory path
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    setState(() {
      _displayImage = imageFile;
    });
  }

  @override
  void initState() {
    super.initState();

    _download();

    for (var assignee in widget.task.assignees) {
      for (var user in _users) {
        if (assignee.id == user['clickup_id']) {
          assignee.telegramUsername = user['telegram_username'];
        }
      }
      contributors.add(assignee.telegramUsername);
    }

    var teleUsers = contributors.join(" ");

    _content =
        '/lapor Open Data Jawa Barat | Follow Up Feedback Open Data\nPeserta: $teleUsers\nLampiran: https://app.clickup.com/t/2cx473f';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${widget.task.name} - ${widget.task.status.toUpperCase()}'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: widget.task.assignees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${widget.task.assignees[index].id} ${widget.task.assignees[index].username}'),
            subtitle: Text(widget.task.assignees[index].email),
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              print(_displayImage);
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      contentPadding: EdgeInsets.all(8),
                      title: const Text('Evidence Photo'),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _displayImage != null
                                ? SizedBox(
                                    height: 150,
                                    child: Image.file(_displayImage!),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Share.shareFiles([_displayImage!.path]);
                                },
                                child: const Text('Send'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.telegram),
                SizedBox(
                  width: 8,
                ),
                Text('Post Evidence'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
