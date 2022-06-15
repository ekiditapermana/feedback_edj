import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/clickup_model.dart';
import 'package:share_plus/share_plus.dart';

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

  @override
  void initState() {
    super.initState();

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
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: 340,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 32,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () async {
                                await Share.share(_content);
                              },
                              child: const Text('Confirm'),
                            ),
                          ),
                        ],
                      ),
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
