import 'package:flutter/material.dart';

import 'todo_repository.dart';

/// A model to describe todo feature behavior.
class TodoModel extends ChangeNotifier {
  ///
  TodoModel({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  ///
  final TodoRepository _todoRepository;

  ///
  final List<Todo> todos = [];

  ///
  Future<void> addTodo(Todo todo) async {
    await _todoRepository.addTodo(todo);
    todos.add(todo);
    notifyListeners();
  }

  ///
  Future<void> updateTodo(Todo todo) async {}
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
