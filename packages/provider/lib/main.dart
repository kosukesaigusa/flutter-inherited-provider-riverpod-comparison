import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/features/todo/todo.dart';
import 'package:provider_example/features/todo/todo_controller.dart';
import 'package:provider_example/features/todo/ui/todos_page.dart';

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
          ChangeNotifierProvider(
            create: (_) => TodoController(
              todoModel: context.read<TodoModel>(),
            ),
          ),
        ],
        child: const TodosPage(),
      ),
    );
  }
}
