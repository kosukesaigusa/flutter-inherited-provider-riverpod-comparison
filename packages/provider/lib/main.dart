import 'package:common/common.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/features/todo/ui/todos_page.dart';

import 'features/todo/todo.dart';
import 'features/todo/todo_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      home: MultiProvider(
        providers: [
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
