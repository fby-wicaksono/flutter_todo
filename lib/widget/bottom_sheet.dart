import 'package:flutter/material.dart';
import 'package:flutter_todo/database/AppDatabase.dart';
import 'package:flutter_todo/database/entity/tasks.dart';
import 'package:flutter_todo/widget/general_text_input.dart';
import 'package:flutter_todo/widget/label_with_value.dart';

void showAppBottomSheet(BuildContext context, Widget bottomSheetLayout) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (context) => bottomSheetLayout,
  );
}

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    Key? key,
    required this.onAddButtonPressed,
  }) : super(key: key);

  final Function(String title, String description) onAddButtonPressed;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add New Task',
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              GeneralTextInput(
                label: 'Title',
                controller: titleController,
              ),
              const SizedBox(height: 15.0),
              GeneralTextInput(
                label: 'Description',
                controller: descriptionController,
                minLines: 4,
                maxLines: 4,
                inputStyle: textTheme.bodyLarge,
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () => widget.onAddButtonPressed(
                  titleController.text,
                  descriptionController.text,
                ),
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailTaskBottomSheet extends StatelessWidget {
  const DetailTaskBottomSheet({
    Key? key,
    required this.task,
    required this.onDeletePressed,
    required this.onCompletePressed,
  }) : super(key: key);

  final Task task;
  final Function(Task task) onDeletePressed;
  final Function(Task task) onCompletePressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelWithValue(
              label: 'Title',
              value: task.title,
            ),
            const SizedBox(height: 15.0),
            LabelWithValue(
              label: 'Description',
              value: task.description,
            ),
            const SizedBox(height: 15.0),
            LabelWithValue(
              label: 'Status',
              value: task.status.statusName,
            ),
            const SizedBox(height: 25.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onDeletePressed(task),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Delete'),
                  ),
                ),
                const SizedBox(width: 10.0),
                if (task.status == TaskStatus.toDo) ...[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onCompletePressed(task),
                      child: const Text('Complete'),
                    ),
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
