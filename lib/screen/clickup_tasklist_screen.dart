import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/clickup_model.dart';
import 'package:mo_opendata_v2/screen/clickup_task_detail_screen.dart';
import 'package:mo_opendata_v2/service/clickup_service.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<ClickUpModel> taskList = [];
  bool isLoading = false;

  Future fetch() async {
    isLoading = true;
    final cs = ClickUpService();
    final newItems = await cs.getClickUpSubtask();

    setState(() {
      isLoading = false;

      taskList.add(newItems);
    });
  }

  Future refresh() async {
    setState(() {
      taskList.clear();

      isLoading = false;
    });

    fetch();
  }

  @override
  void initState() {
    super.initState();

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Project: ',
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                taskList[index].projectName,
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Subtask: ',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                taskList[index].name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: subtask(index, context),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Column subtask(int index, BuildContext context) {
    return Column(
      children: taskList[index].subtasks.map(
        (subtask) {
          return Column(
            children: [
              ListTile(
                title: Text(subtask.name),
                subtitle: Text(subtask.status),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetail(
                        task: subtask,
                        attachments: taskList[index].attachments,
                      ),
                    ),
                  );
                },
              ),
              const Divider()
            ],
          );
        },
      ).toList(),
    );
  }
}
