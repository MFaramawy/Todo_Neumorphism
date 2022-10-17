import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final int color;
  final int status;
  final String date;
  final String note;
  final String title;
  final int reminder;
  final String repeat;
  final String endTime;
  final String startTime;

  const TaskEntity({
    this.id,
    required this.date,
    required this.note,
    required this.title,
    required this.color,
    required this.status,
    required this.repeat,
    required this.endTime,
    required this.reminder,
    required this.startTime,
  });

  @override
  List<Object?> get props => [
        id,
        note,
        date,
        title,
        color,
        status,
        repeat,
        endTime,
        reminder,
        startTime
      ];
}
