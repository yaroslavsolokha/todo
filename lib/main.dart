import 'package:flutter/material.dart';
import 'package:todo/screens/todo_list.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    ),
  );
}
