import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/features/todo/ui/todos_page.dart';
import 'package:provider_example/features/todo_repository.dart';

import 'features/todo/todo.dart';
import 'features/todo/todo_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          // TODO: Check use Provider.value on not?
          Provider<TodoRepository>(create: (_) => FirestoreTodoRepository()),
        ],
        child: ChangeNotifierProvider<TodoModel>(
          create: (context) => TodoModel(
            todoRepository: context.read<TodoRepository>(),
          ),
          child: ChangeNotifierProvider<TodoController>(
            create: (context) => TodoController(
              todoModel: context.read<TodoModel>(),
            ),
            child: const TodosPage(),
          ),
        ),
      ),
    );
  }
}
