import 'package:common/src/firestore_refs.dart';

import '../common.dart';

/// Todo repository interface.
abstract class TodoRepository {
  /// Add a new document to todos collection.
  Future<void> addTodo(Todo todo);

  /// Fetch documents in todos collection.
  Future<List<Todo>> fetchTodos();

  /// Update completed status of specified [Todo].
  Future<void> updateIsCompleted({required String id, required bool value});
}

/// Todo repository connected with Cloud Firestore.
class FirestoreTodoRepository implements TodoRepository {
  @override
  Future<void> addTodo(Todo todo) async => todosCollectionReference.add(todo);

  @override
  Future<List<Todo>> fetchTodos() async {
    final querySnapshot = await todosCollectionReference.get();
    final todos = querySnapshot.docs
        .map((queryDocumentSnapshot) => queryDocumentSnapshot.data())
        .toList();
    return todos;
  }

  @override
  Future<void> updateIsCompleted({
    required String id,
    required bool value,
  }) =>
      todoDocumentReference(id: id).update(<String, dynamic>{
        'isCompleted': value,
      });
}
