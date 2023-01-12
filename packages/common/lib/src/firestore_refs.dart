import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';

/// Reference to todos collection.
final todosCollectionReference =
    FirebaseFirestore.instance.collection('todos').withConverter(
          fromFirestore: (ds, _) => Todo.fromDocumentSnapshot(ds),
          toFirestore: (obj, __) => obj.toJson(),
        );

/// Reference to specified todo document.
DocumentReference<Todo> todoDocumentReference({required String id}) =>
    todosCollectionReference.doc(id);
