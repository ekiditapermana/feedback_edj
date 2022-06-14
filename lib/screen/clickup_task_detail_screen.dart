import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/clickup_model.dart';
import 'package:share_plus/share_plus.dart';

class TaskDetail extends StatelessWidget {
  final Subtask task;
  const TaskDetail({Key? key, required this.task}) : super(key: key);

  final String content =
      '/lapor Open Data Jawa Barat | Follow Up Feedback Open Data\nPeserta: @iqbalali167\nLampiran: https://app.clickup.com/t/2cx473f';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${task.name} - ${task.status.toUpperCase()}'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: task.assignees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${task.assignees[index].id} ${task.assignees[index].username}'),
            subtitle: Text(task.assignees[index].email),
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await Share.share(content);
            },
            child: Row(
              children: const [
                Icon(Icons.telegram),
                SizedBox(
                  width: 24,
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
