import 'package:anywhere/approuter.dart';
import 'package:anywhere/core/services/navigation_service.dart';
import 'package:anywhere/locator.dart';
import 'package:anywhere/view/widgets/scroll_behavior.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: AppRouter.itemListView,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: child!,
        );
      },
    );
  }
}
