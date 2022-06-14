import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/clickup_model.dart';

class TaskDetail extends StatelessWidget {
  final Subtask task;
  const TaskDetail({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.name)),
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
    );
  }
}
