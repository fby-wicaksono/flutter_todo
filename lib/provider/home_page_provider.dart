import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/database/AppDatabase.dart';
import 'package:flutter_todo/database/entity/tasks.dart';
import 'package:flutter_todo/notifier/task_list_notifier.dart';

final taskListNotifierProvider =
    StateNotifierProvider.autoDispose<TaskListNotifier, List<Task>>((ref) => TaskListNotifier(ref));

final totalPendingTasksProvider = Provider.autoDispose((ref) {
    final taskList = ref.watch(taskListNotifierProvider);
    final filteredList = taskList.where((element) => element.status == TaskStatus.toDo);

    return filteredList.length;
});
