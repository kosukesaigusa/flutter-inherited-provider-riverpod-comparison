import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/features/todo/todo.dart';

import '../todo_controller.dart';

/// Todos page.
class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoController>().fetchTodos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoModel>().todos;
    final isLoading = context.select<TodoController, bool>((c) => c.isLoading);
    final isSending = context.select<TodoController, bool>((c) => c.isSending);
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => context.read<TodoController>().fetchTodos(),
              child: ListView.builder(
                itemCount: todos.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return _TodoItem(todo: todo);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: isSending
            ? null
            : () {
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

/// Each todo item widget.
class _TodoItem extends StatelessWidget {
  const _TodoItem({required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final isSending = context.select<TodoController, bool>((c) => c.isSending);
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: isSending
            ? null
            : (value) async {
                if (value == null) {
                  return;
                }
                await context
                    .read<TodoController>()
                    .updateTodo(id: todo.id, value: value);
              },
      ),
      title: Text(todo.title),
      subtitle: Text(todo.id),
    );
  }
}
