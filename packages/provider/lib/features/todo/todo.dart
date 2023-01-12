import 'package:common/common.dart';
import 'package:flutter/material.dart';

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
