import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'todo.dart';

///
class TodoController extends ChangeNotifier {
  TodoController({
    required TodoModel todoModel,
  }) : _todoModel = todoModel;

  ///
  final TodoModel _todoModel;

  ///
  bool _isLoading = false;

  ///
  bool get isLoading => _isLoading;

  ///
  void addTodo(Todo todo) => _todoModel.addTodo(todo);

  ///
  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  ///
  void _endLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
