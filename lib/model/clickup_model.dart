class ClickUpModel {
  final String id;
  final String name;
  final List<Subtask> subtasks;

  ClickUpModel({
    required this.id,
    required this.name,
    required this.subtasks,
  });

  factory ClickUpModel.fromJson(Map<String, dynamic> json) => ClickUpModel(
        id: json['id'],
        name: json['name'],
        subtasks: List<Subtask>.from(json['subtasks'].map(
          (subtask) => Subtask.fromJson(subtask),
        )),
      );
}

class Subtask {
  final String id;
  final String name;
  final String status;
  final List<Assignee> assignees;

  Subtask({
    required this.id,
    required this.name,
    required this.status,
    required this.assignees,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) => Subtask(
        id: json['id'],
        name: json['name'],
        status: json['status']['status'],
        assignees: List<Assignee>.from(json['assignees'].map(
          (assignee) => Assignee.fromJson(assignee),
        )),
      );
}

class Assignee {
  final int id;
  final String username;
  final String email;

  Assignee({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        id: json['id'],
        username: json['username'],
        email: json['email'],
      );
}
