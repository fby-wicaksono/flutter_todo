import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/database/entity/tasks.dart';
import 'package:flutter_todo/page/home_page.dart';
import 'package:flutter_todo/provider/todo_repository_provider.dart';
import 'package:flutter_todo/widget/task_item.dart';
import 'package:mockito/mockito.dart';

import '../test_util/mock/repository_mock.mocks.dart';
import '../test_util/test_model.dart';
import '../test_util/test_util.dart';

void main() {
  late MockTodoRepo mockTodoRepo;

  final taskListSample = [
    buildTaskFromTemplate(),
    buildTaskFromTemplate(
      title: 'Task 2',
      description: 'description for task 2',
    ),
    buildTaskFromTemplate(
      title: 'Task 3',
      description: 'description for task 3',
    ),
    buildTaskFromTemplate(
      title: 'Task 4',
      description: 'description for task 4',
      status: TaskStatus.completed,
    ),
  ];

  final textWithStrikeThrough = find.byWidgetPredicate(
    (widget) => widget is Text && widget.style?.decoration == TextDecoration.lineThrough,
    description: 'Text with strike through',
  );

  setUp(() {
    mockTodoRepo = MockTodoRepo();
  });

  testWidgets('''
  Given the app opened
  And Home page displayed
  Then all UI will be displayed accordingly
  ''', (tester) async {
    await tester.pumpWidget(const TestApp(child: HomePage()));

    await tester.pumpAndSettle();

    expect(find.widgetWithText(HeaderWidget, 'Task List'), findsOneWidget);
    expect(find.widgetWithText(HeaderWidget, 'New Task'), findsOneWidget);
    expect(find.widgetWithText(HeaderWidget, '0 Pending Task'), findsOneWidget);
  });

  testWidgets('''
  Given home page opened
  And there are 3 pending task
  Then in header there will be text telling 3 tasks are pending
  ''', (tester) async {
    when(mockTodoRepo.getAllTasks()).thenAnswer((_) async => taskListSample);

    await tester.pumpWidget(
      TestApp(
        overrides: [todoRepositoryProvider.overrideWithValue(mockTodoRepo)],
        child: const HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.widgetWithText(HeaderWidget, '3 Pending Task'), findsOneWidget);
  });

  testWidgets('''
  Given home page opened
  And there are 4 tasks
  Then there will be 4 cards shown
  ''', (tester) async {
    when(mockTodoRepo.getAllTasks()).thenAnswer((_) async => taskListSample);

    await tester.pumpWidget(
      TestApp(
        overrides: [todoRepositoryProvider.overrideWithValue(mockTodoRepo)],
        child: const HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.widgetWithText(TaskItem, 'Task 1'), findsOneWidget);
    expect(find.widgetWithText(TaskItem, 'Description for task number 1'), findsOneWidget);

    expect(find.widgetWithText(TaskItem, 'Task 2'), findsOneWidget);
    expect(find.widgetWithText(TaskItem, 'description for task 2'), findsOneWidget);

    expect(find.widgetWithText(TaskItem, 'Task 3'), findsOneWidget);
    expect(find.widgetWithText(TaskItem, 'description for task 3'), findsOneWidget);

    expect(find.widgetWithText(TaskItem, 'Task 4'), findsOneWidget);
    expect(find.widgetWithText(TaskItem, 'description for task 4'), findsOneWidget);
  });

  testWidgets('''
  Given home page opened
  And there is 1 completed task
  Then there will be 1 task marked as completed
  And have a text strikethrough style
  ''', (tester) async {
    when(mockTodoRepo.getAllTasks()).thenAnswer((_) async => taskListSample);

    await tester.pumpWidget(
      TestApp(
        overrides: [todoRepositoryProvider.overrideWithValue(mockTodoRepo)],
        child: const HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(textWithStrikeThrough, findsNWidgets(2));
  });
}
