import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/database/AppDatabase.dart';

final databaseProvider = Provider.autoDispose((ref) => AppDatabase());