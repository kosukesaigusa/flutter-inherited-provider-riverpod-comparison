import 'package:cloud_firestore/cloud_firestore.dart';

/// An entity class of Todo.
class Todo {
  const Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: (json['id'] ?? '') as String,
        title: (json['title'] ?? '') as String,
        isCompleted: (json['isCompleted'] ?? false) as bool,
      );

  factory Todo.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> ds) {
    final json = ds.data()!;
    return Todo.fromJson(<String, dynamic>{
      'id': ds.id,
      ...json,
    });
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  ///
  final String id;

  ///
  final String title;

  ///
  final bool isCompleted;
}
