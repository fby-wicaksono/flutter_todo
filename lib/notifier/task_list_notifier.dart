import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/database/AppDatabase.dart';
import 'package:flutter_todo/database/entity/tasks.dart';
import 'package:flutter_todo/provider/todo_repository_provider.dart';

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier(this.ref, {List<Task>? initialTaskList}) : super(initialTaskList ?? []);

  final Ref ref;

  void addTask({
    required String title,
    required String description,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      return;
    }

    final repo = ref.read(todoRepositoryProvider);
    final taskCompanion = TasksCompanion.insert(
      title: title,
      description: description,
      status: TaskStatus.toDo,
    );

    final insertedId = await repo.addTask(taskCompanion);

    state = [
      ...state,
      Task(id: insertedId, title: title, description: description, status: TaskStatus.toDo),
    ];
  }

  void getAllTask() async {
    final repo = ref.read(todoRepositoryProvider);

    final taskList = await repo.getAllTasks();

    state = taskList;
  }

  void updateTaskToCompeted(Task selectedTask) async {
    final repo = ref.read(todoRepositoryProvider);

    final updatedTask = selectedTask.copyWith(status: TaskStatus.completed);

    await repo.updateTask(updatedTask);

    state = [
      for (final task in state)
        if (task.id == updatedTask.id)
          task.copyWith(status: TaskStatus.completed)
        else
          task
    ];
  }

  void deleteTask(Task selectedTask) async {
    final repo = ref.read(todoRepositoryProvider);

    await repo.deleteTask(selectedTask);

    state = [
      for (final task in state)
        if (task.id != selectedTask.id)
          task
    ];
  }
}
