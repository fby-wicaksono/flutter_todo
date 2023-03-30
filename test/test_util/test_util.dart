import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestApp extends StatelessWidget {
  const TestApp({
    Key? key,
    required this.child,
    this.overrides = const [],
  }) : super(key: key);

  final List<Override> overrides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: child,
      ),
    );
  }
}