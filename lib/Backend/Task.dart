import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title, description;
  bool completed;
  Timestamp timestamp;
  Task(
      {required this.title,
      required this.description,
      required this.completed,
      required this.timestamp});
}
