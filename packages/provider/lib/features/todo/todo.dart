import 'package:flutter/material.dart';

/// A model to define todo related features' behavior.
class TodoModel extends ChangeNotifier {
  // ///
  // ProviderTodo({required TodoRepository todoRepository})
  //     : _todoRepository = todoRepository;

  // ///
  // final TodoRepository _todoRepository;

  ///
  final List<Todo> todos = [];

  ///
  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }
}

/// An entity class of Todo.
class Todo {
  const Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: (json['id'] ?? '') as String,
        title: (json['title'] ?? '') as String,
        isCompleted: (json['isCompleted'] ?? false) as bool,
      );

  ///
  final String id;

  ///
  final String title;

  ///
  final bool isCompleted;
}
