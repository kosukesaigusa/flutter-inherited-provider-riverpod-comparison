import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/features/todo/todo.dart';

import '../todo_controller.dart';

///
class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoModel>().todos;
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final todo = todos[index];
          return _TodoItem(todo: todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final now = DateTime.now();
          context.read<TodoController>().addTodo(
                Todo(
                  id: now.toString(),
                  title: now.toString(),
                  isCompleted: false,
                ),
              );
        },
      ),
    );
  }
}

///
class _TodoItem extends StatelessWidget {
  const _TodoItem({required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {},
      ),
      title: Text(todo.title),
    );
  }
}
