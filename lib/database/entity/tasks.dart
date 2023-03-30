import 'package:drift/drift.dart';

enum TaskStatus {
  toDo('To Do'),
  completed('Completed');

  final String statusName;
  const TaskStatus(this.statusName);
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get status => textEnum<TaskStatus>()();
}