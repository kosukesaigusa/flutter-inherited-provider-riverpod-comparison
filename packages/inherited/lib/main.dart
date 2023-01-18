import 'package:flutter/material.dart';

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
      home: const CounterPage(),
    );
  }
}

class _InheritedCounter extends InheritedWidget {
  const _InheritedCounter({
    required super.child,
    required this.counter,
  });

  final int counter;

  @override
  bool updateShouldNotify(_InheritedCounter _) => true;

  static _InheritedCounter? of(
    BuildContext context, {
    bool listen = true,
  }) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedCounter>()
        : context
            .getElementForInheritedWidgetOfExactType<_InheritedCounter>()
            ?.widget as _InheritedCounter?;
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedCounter(
      counter: _counter,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              _CounterText(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText();

  @override
  Widget build(BuildContext context) {
    final inheritedCounter = _InheritedCounter.of(context);
    return Text(
      '${inheritedCounter?.counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
