import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String id, name;
  List<String> admins;
  String founder;
  List<String> users;
  String? image_url;
  List<int> non_viewed_tasks;
  Timestamp created_at;

  Group(
      {required this.id,
      required this.name,
      required this.admins,
      required this.founder,
      required this.non_viewed_tasks,
      required this.users,
      required this.created_at});
}
