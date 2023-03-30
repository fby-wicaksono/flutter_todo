import 'package:auto_route/annotations.dart';
import 'package:flutter_todo/page/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      path: '/home',
      initial: true,
    ),
  ],
)
class $AppRouter {}