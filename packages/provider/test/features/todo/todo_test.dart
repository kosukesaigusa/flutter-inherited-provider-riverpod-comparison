import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_example/features/todo/todo.dart';

import 'todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late final TodoModel todoModel;
  late final TodoRepository todoRepository;

  setUpAll(() {
    todoRepository = MockTodoRepository();
    todoModel = TodoModel(todoRepository: todoRepository);
  });

  group('TodoModel のテスト。', () {
    test('fetchTodos メソッドのテスト。', () async {
      expect(todoModel.todos, const <Todo>[]);
      final expected = [_FakeTodo(), _FakeTodo()];
      when(todoRepository.fetchTodos())
          .thenAnswer((_) => Future<List<Todo>>.value(expected));
      await todoModel.fetchTodos();
      expect(todoModel.todos, expected);
    });
  });
}

class _FakeTodo extends Fake implements Todo {}
