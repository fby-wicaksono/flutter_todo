import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/provider/database_provider.dart';
import 'package:flutter_todo/repository/todo_repo.dart';

final todoRepositoryProvider = Provider.autoDispose((ref) => TodoRepo(database: ref.read(databaseProvider)));