// Task
class ClickUpModel {
  final String id;
  final String name;
  final String projectName;
  final List<Attachment> attachments;
  final List<Subtask> subtasks;

  ClickUpModel({
    required this.id,
    required this.name,
    required this.projectName,
    required this.subtasks,
    required this.attachments,
  });

  factory ClickUpModel.fromJson(Map<String, dynamic> json) => ClickUpModel(
        id: json['id'],
        name: json['name'],
        projectName: json['project']['name'],
        subtasks: List<Subtask>.from(json['subtasks'].map(
          (subtask) => Subtask.fromJson(subtask),
        )),
        attachments: List<Attachment>.from(json['attachments'].map(
          (attachment) => Attachment.fromJson(attachment),
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
  String? telegramUsername;

  Assignee({
    required this.id,
    required this.username,
    required this.email,
    this.telegramUsername,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        id: json['id'],
        username: json['username'],
        email: json['email'],
      );
}

class Attachment {
  final String url;

  Attachment({
    required this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        url: json['url'],
      );
}
