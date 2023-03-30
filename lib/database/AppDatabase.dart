import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_todo/database/entity/tasks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'AppDatabase.g.dart';

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(): super(_openConnection());

  // Insert new task that return assigned ID
  Future<int> addTask(TasksCompanion task) {
    return into(tasks).insert(task);
  }

  // Update task
  Future<bool> updateTask(Task task) {
    return update(tasks).replace(task);
  }

  // Delete task
  Future deleteTask(Task task) {
    return (delete(tasks)..where((t) => t.id.equals(task.id))).go();
  }

  // Get all tasks
  Future<List<Task>> get getAllTasks => select(tasks).get();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
