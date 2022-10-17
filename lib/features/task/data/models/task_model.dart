import 'package:todo_app/features/task/domain/entities/task.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    int? id,
    required int color,
    required int status,
    required String date,
    required String note,
    required String title,
    required int reminder,
    required String repeat,
    required String endTime,
    required String startTime,
  }) : super(
          id: id,
          date: date,
          note: note,
          title: title,
          color: color,
          repeat: repeat,
          status: status,
          endTime: endTime,
          reminder: reminder,
          startTime: startTime,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        date: json['date'],
        note: json['note'],
        title: json['title'],
        color: json['color'],
        repeat: json['repeat'],
        status: json['status'],
        endTime: json['endTime'],
        reminder: json['reminder'],
        startTime: json['startTime'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'note': note,
        'title': title,
        'color': color,
        'repeat': repeat,
        'status': status,
        'endTime': endTime,
        'reminder': reminder,
        'startTime': startTime,
      };
}
