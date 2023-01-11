import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/features/todo/todo.dart';

import '../todo_controller.dart';

///
class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ChangeNotifierProvider<TodoModel>(
        create: (context) => TodoModel(),
        child: Consumer<TodoModel>(
          builder: (context, todoModel, child) => ListView.builder(
            itemCount: todoModel.todos.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final todo = todoModel.todos[index];
              return _TodoItem(todo: todo);
            },
          ),
        ),
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
    return const SizedBox();
  }
}
