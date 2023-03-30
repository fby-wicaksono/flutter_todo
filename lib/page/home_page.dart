import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/database/AppDatabase.dart';
import 'package:flutter_todo/provider/home_page_provider.dart';
import 'package:flutter_todo/widget/bottom_sheet.dart';
import 'package:flutter_todo/widget/task_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    ref.read(taskListNotifierProvider.notifier).getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(taskListNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              HeaderWidget(
                onAddButtonPressed: () => showAppBottomSheet(
                  context,
                  AddTaskBottomSheet(
                    onAddButtonPressed: (title, desc) => _onAddButtonPressed(
                      title,
                      desc,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => TaskItem(
                    task: taskList[index],
                    onItemPressed: () => showAppBottomSheet(
                      context,
                      DetailTaskBottomSheet(
                        task: taskList[index],
                        onCompletePressed: (task) => _onCompleteButtonPressed(taskList[index]),
                        onDeletePressed: (task) => _onDeleteButtonPressed(taskList[index]),
                      ),
                    ),
                  ),
                  itemCount: taskList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAddButtonPressed(String title, String desc) {
    context.router.pop();
    ref.read(taskListNotifierProvider.notifier).addTask(title: title, description: desc);
  }

  void _onCompleteButtonPressed(Task task) {
    context.router.pop();
    ref.read(taskListNotifierProvider.notifier).updateTaskToCompeted(task);
  }

  void _onDeleteButtonPressed(Task task) {
    context.router.pop();
    ref.read(taskListNotifierProvider.notifier).deleteTask(task);
  }
}

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({Key? key, required this.onAddButtonPressed}) : super(key: key);

  final VoidCallback onAddButtonPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final totalPendingTask = ref.watch(totalPendingTasksProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task List',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '$totalPendingTask Pending Task',
                style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        ElevatedButton.icon(
          onPressed: onAddButtonPressed,
          icon: const Icon(
            Icons.add,
            size: 24.0,
          ),
          label: const Text('New Task'),
        )
      ],
    );
  }
}
