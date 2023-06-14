import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'Screen.dart';

void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.redAccent
          ),
          primarySwatch: Colors.green,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            secondary: Colors.redAccent
          ),
          fontFamily: 'JetBrains',
          textTheme: ThemeData.light().textTheme.copyWith(
            displayLarge: TextStyle(
              color: Colors.green,
              fontFamily: 'JetBrains',
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            titleMedium: TextStyle(
              color: Colors.green,
              fontFamily: 'JetBrains',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: 'To Do List',
        home: Screen(),
      ),
    );
  }
}