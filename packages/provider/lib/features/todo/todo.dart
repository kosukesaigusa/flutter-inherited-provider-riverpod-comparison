import 'package:common/common.dart';
import 'package:flutter/material.dart';

/// A model to describe todo feature behavior.
class TodoModel extends ChangeNotifier {
  TodoModel({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  /// Todo repository interface.
  final TodoRepository _todoRepository;

  /// Fetched todos.
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  /// Fetch todos from repository interface and update todos.
  Future<void> fetchTodos() async {
    final todos = await _todoRepository.fetchTodos();
    _todos
      ..clear()
      ..addAll(todos);
    notifyListeners();
  }

  /// Add a new todo against repository interface and update todos.
  Future<void> addTodo(Todo todo) async {
    await _todoRepository.addTodo(todo);
    todos.add(todo);
    notifyListeners();
  }

  /// Update specified todo's completed status against repository interface and
  /// update todos.
  Future<void> updateTodo({required String id, required bool value}) async {
    await _todoRepository.updateIsCompleted(id: id, value: value);
    final updatedTodos = [
      for (final todo in _todos)
        if (todo.id == id)
          Todo(id: todo.id, title: todo.title, isCompleted: value)
        else
          todo,
    ];
    _todos
      ..clear()
      ..addAll(updatedTodos);
    notifyListeners();
  }
}
