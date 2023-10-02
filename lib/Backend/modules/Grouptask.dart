import 'package:cloud_firestore/cloud_firestore.dart';

class GroupTask {
  String title, description, id;
  List<bool> completed;
  Timestamp start_date, finish_date;
  int likes, dislikes;
  List<String> comments;
  String group_id;
  String creator_id;
  GroupTask(
      {required this.title,
      required this.description,
      required this.id,
      required this.comments,
      required this.completed,
      required this.creator_id,
      required this.dislikes,
      required this.finish_date,
      required this.group_id,
      required this.likes,
      required this.start_date});
}
