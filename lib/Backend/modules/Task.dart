import 'package:flutter/material.dart';

class Task {
  String title, description;
  bool completed;
  DateTime date;
  TimePickerEntryMode? timedeadline;
  Task(
      {required this.title,
      required this.description,
      required this.completed,
      required this.date});
}
