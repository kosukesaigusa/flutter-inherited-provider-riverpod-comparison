import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_example/features/todo/todo.dart';

import 'todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late final TodoRepository todoRepository;

  setUpAll(() {
    todoRepository = MockTodoRepository();
  });

  group('TodoModel のテスト。', () {
    test('fetchTodos メソッドのテスト。', () async {
      final todoModel = TodoModel(todoRepository: todoRepository);
      expect(todoModel.todos, const <Todo>[]);
      final expected = [_FakeTodo(), _FakeTodo()];
      when(todoRepository.fetchTodos())
          .thenAnswer((_) => Future<List<Todo>>.value(expected));
      await todoModel.fetchTodos();
      expect(todoModel.todos, expected);
    });

    test('addTodo メソッドのテスト。', () async {
      final todoModel = TodoModel(todoRepository: todoRepository);
      final todos = [_FakeTodo(), _FakeTodo()];
      for (final todo in todos) {
        when(
          todoRepository.addTodo(
            todo,
          ),
        ).thenAnswer((_) => Future<void>.value());
        await todoModel.addTodo(todo);
      }
      expect(todoModel.todos, todos);
    });
  });
}

class _FakeTodo extends Fake implements Todo {}
