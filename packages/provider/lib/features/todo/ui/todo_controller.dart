import 'package:common/common.dart';
import 'package:flutter/material.dart';

import '../todo.dart';

/// Controller to let users to handle Todo related features.
class TodoController extends ChangeNotifier {
  TodoController({
    required TodoModel todoModel,
  }) : _todoModel = todoModel;

  /// [TodoModel] instance.
  final TodoModel _todoModel;

  bool _isLoading = false;
  bool _isSending = false;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;

  /// Fetch todos and handle loading state.
  Future<void> fetchTodos() async {
    _startLoading();
    try {
      await _todoModel.fetchTodos();
    } finally {
      _endLoading();
    }
  }

  /// Add a new todo and handle sending state.
  Future<void> addTodo(Todo todo) async {
    _startSending();
    try {
      await _todoModel.addTodo(todo);
    } finally {
      _endSending();
    }
  }

  /// Update specified todo's completed status and handle sending state.
  Future<void> updateTodo({required String id, required bool value}) async {
    _startSending();
    try {
      await _todoModel.updateTodo(id: id, value: value);
    } finally {
      _endSending();
    }
  }

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _endLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void _startSending() {
    _isSending = true;
    notifyListeners();
  }

  void _endSending() {
    _isSending = false;
    notifyListeners();
  }
}
