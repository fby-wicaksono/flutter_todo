import 'package:flutter_todo/database/AppDatabase.dart';
import 'package:flutter_todo/database/entity/tasks.dart';

Task buildTaskFromTemplate({
  int id = 1,
  String title = 'Task 1',
  String description = 'Description for task number 1',
  TaskStatus status = TaskStatus.toDo,
}) {
  return Task(
    id: id,
    title: title,
    description: description,
    status: status,
  );
}
