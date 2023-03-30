import 'package:flutter/material.dart';
import 'package:flutter_todo/database/AppDatabase.dart';
import 'package:flutter_todo/database/entity/tasks.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.task,
    required this.onItemPressed,
  }) : super(key: key);

  final Task task;
  final VoidCallback onItemPressed;

  TextDecoration? get _textDecoration {
    return task.status == TaskStatus.completed ? TextDecoration.lineThrough : null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      child: InkWell(
        onTap: onItemPressed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: _textDecoration
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                task.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  decoration: _textDecoration
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
