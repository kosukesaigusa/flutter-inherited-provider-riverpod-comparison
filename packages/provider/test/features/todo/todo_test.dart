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
          todoRepository.addTodo(todo),
        ).thenAnswer((_) => Future<void>.value());
        await todoModel.addTodo(todo);
      }
      expect(todoModel.todos, todos);
    });

    test('updateTodo メソッドのテスト。', () async {
      final todoModel = TodoModel(todoRepository: todoRepository);
      final todos = [
        _FakeTodoWithProps(
          id: 'todo-1',
          title: 'todo-1-title',
          isCompleted: false,
        ),
        _FakeTodoWithProps(
          id: 'todo-2',
          title: 'todo-2-title',
          isCompleted: false,
        ),
      ];
      for (final todo in todos) {
        when(
          todoRepository.addTodo(todo),
        ).thenAnswer((_) => Future<void>.value());
        await todoModel.addTodo(todo);
      }
      final id = todos[0].id;
      when(
        todoRepository.updateIsCompleted(
          id: id,
          value: true,
        ),
      ).thenAnswer((_) => Future<void>.value());
      await todoModel.updateTodo(id: id, value: true);
      expect(todoModel.todos[0].isCompleted, true);
      expect(todoModel.todos[1].isCompleted, false);
      expect(todoModel.todos.length, 2);
    });
  });
}

class _FakeTodo extends Fake implements Todo {}

class _FakeTodoWithProps extends Fake implements Todo {
  _FakeTodoWithProps({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
  @override
  String id;

  @override
  String title;

  @override
  bool isCompleted;
}
