import 'package:provider_example/features/todo/todo.dart';

///
abstract class TodoRepository {
  ///
  Future<void> addTodo(Todo todo);

  ///
  Future<List<Todo>> fetchTodos();

  ///
  Future<void> updateIsCompleted({required Todo todo, required bool value});
}

///
class FirestoreTodoRepository implements TodoRepository {
  @override
  Future<void> addTodo(Todo todo) async {}

  @override
  Future<List<Todo>> fetchTodos() async {
    return [];
  }

  @override
  Future<void> updateIsCompleted({
    required Todo todo,
    required bool value,
  }) async {
    return;
  }
}
