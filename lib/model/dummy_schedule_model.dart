// final List<Map<String, dynamic>> schedule = [
//   {
//     "id": 1,
//     "clickup_userid": "5983695",
//     "task_list": [
//       {
//         "id": 1,
//         "task_name": "Hotline Open Data Jabar",
//       },
//       {
//         "id": 2,
//         "task_name": "Create Content Pikobar",
//       },
//     ],
//     "name": "iqbal",
//   },
//   {
//     "id": 2,
//     "name": "arifatus",
//     "task_list": [
//       {
//         "id": 1,
//         "task_name": "Hotline Open Data Jabar",
//       },
//       {
//         "id": 2,
//         "task_name": "Hotline Sapawarga",
//       },
//     ],
//   },
//   {
//     "id": 3,
//     "name": "nia",
//     "task_list": [
//       {
//         "id": 1,
//         "task_name": "Hotline Open Data Jabar",
//       },
//       {
//         "id": 2,
//         "task_name": "Hotline Pikobar",
//       },
//     ],
//   },
// ];

class Schedule {
  final int id;
  final String userName;
  final List<Task> taskList;
  final String date;
  final String type;
  final int shift;
  final String notes;

  Schedule({
    required this.id,
    required this.userName,
    required this.taskList,
    required this.date,
    required this.type,
    required this.shift,
    required this.notes,
  });
}

class Task {
  final int id;
  final String taskName;

  Task({
    required this.id,
    required this.taskName,
  });
}

final List<Schedule> scheduleList = [
  Schedule(
    id: 1,
    userName: 'Iqbal',
    taskList: [
      Task(
        id: 1,
        taskName: 'Hotline Open Data Jawa Barat',
      ),
      Task(
        id: 2,
        taskName: 'Create Konten Infografis ',
      ),
      Task(
        id: 3,
        taskName: 'Follow Up Feedback Open Data',
      ),
    ],
    date: '2022-06-01',
    type: 'WFH',
    shift: 3,
    notes: '',
  ),
  Schedule(
    id: 2,
    userName: 'Arifatus',
    taskList: [
      Task(
        id: 1,
        taskName: 'Hotline Open Data Jawa Barat',
      ),
      Task(
        id: 2,
        taskName: 'Hotline Sapawarga',
      ),
      Task(
        id: 3,
        taskName: 'Follow Up Feedback Open Data',
      ),
    ],
    date: '2022-06-01',
    type: 'WFO',
    shift: 1,
    notes: '',
  ),
  Schedule(
    id: 3,
    userName: 'Rima',
    taskList: [
      Task(
        id: 3,
        taskName: 'Follow Up Feedback Open Data',
      ),
      Task(
        id: 4,
        taskName: 'Medsos Pikobar',
      ),
    ],
    date: '2022-06-01',
    type: 'WFO',
    shift: 2,
    notes: '',
  ),
  Schedule(
    id: 3,
    userName: 'Nia',
    taskList: [
      Task(
        id: 4,
        taskName: 'Hotline sapawarga',
      ),
      Task(
        id: 4,
        taskName: 'Medsos Pikobar',
      ),
    ],
    date: '2022-06-01',
    type: 'WFO',
    shift: 2,
    notes: '',
  ),
];
