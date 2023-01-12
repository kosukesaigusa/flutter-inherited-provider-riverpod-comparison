import 'package:cloud_firestore/cloud_firestore.dart';

/// An entity class of Todo.
class Todo {
  const Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.createdAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: (json['id'] ?? '') as String,
        title: (json['title'] ?? '') as String,
        isCompleted: (json['isCompleted'] ?? false) as bool,
        createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      );

  factory Todo.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> ds) {
    final json = ds.data()!;
    return Todo.fromJson(<String, dynamic>{
      ...json,
      'id': ds.id,
    });
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'createdAt': FieldValue.serverTimestamp(),
      };

  final String id;

  final String title;

  final bool isCompleted;

  final DateTime? createdAt;
}
