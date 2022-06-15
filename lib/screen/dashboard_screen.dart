import 'package:flutter/material.dart';

import 'package:mo_opendata_v2/model/dummy_schedule_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> partners = [];
  List<Schedule> _scheduleList = [];

  final today = '2022-06-01';
  final userName = 'Iqbal';
  final taskId = 3;

  void getPartners() {
    List<Schedule> result = [];
    for (var schedule in scheduleList) {
      if (schedule.userName == userName) {
        continue;
      }
      if (schedule.date == today) {
        for (var task in schedule.taskList) {
          if (task.id == taskId) {
            result.add(schedule);
          }
        }
      }
    }

    setState(() {
      _scheduleList = result;
    });
  }

  Widget _scheduleListWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: scheduleList.length,
        itemBuilder: (context, index) {
          if (scheduleList[index].id == 1) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(scheduleList[index].date),
                    subtitle: Text(
                      '${scheduleList[index].type} / Shift ${scheduleList[index].shift.toString()}',
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Project: Open Data Jawa Barat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Work Partners'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _partners(),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }

  @override
  void initState() {
    super.initState();

    getPartners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                // CircleAvatar(
                //   backgroundColor: Colors.blue,
                //   child: Text('I'),
                // ),
                // SizedBox(
                //   width: 10,
                // ),

                Text(
                  'Hallo, Muhammad Iqbal Ali!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          _scheduleListWidget(),
        ],
      ),
    );
  }

  Widget _partners() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _scheduleList.length,
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            '- ${_scheduleList[index].userName} (${_scheduleList[index].type} / Shift ${_scheduleList[index].shift.toString()})',
          ),
        );
      },
    );
  }
}
