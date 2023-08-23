import 'package:cloud_firestore/cloud_firestore.dart';

import 'Task.dart';

class Taskmangementservice {
  static final Taskmangementservice _instance = Taskmangementservice._();
  Taskmangementservice._();

  factory Taskmangementservice() => _instance;

  late final CollectionReference taskscollection;

  Future<void> init() async {
    try {
      taskscollection = FirebaseFirestore.instance.collection("tasks");
    } catch (e) {}
  }

  double completed_task({required List<Task> tasks}) {
    try {
      return (tasks.where((element) => element.completed == true).length != 0)
          ? tasks.where((element) => element.completed == true).length /
              tasks.length
          : 0;
    } catch (e) {}
    return 0;
  }

  Future<void> add_task(
      {required String title,
      required String description,
      required String email}) async {
    try {
      await taskscollection.add({
        "user": email,
        "title": title,
        "completed": false,
        "description": description,
        "date": DateTime.now()
      });
    } catch (e) {}
  }

  Future<List<Task>> get_tasks({required String email}) async {
    try {
      List<Task> tasks = [];

      QuerySnapshot querySnapshot =
          await taskscollection.where("user", isEqualTo: email).get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        dynamic docdata = doc.data();

        if (docdata != null) {
          tasks.add(Task(
              title: docdata["title"],
              description: docdata["description"] ?? "",
              completed: docdata["completed"] ?? false,
              date: (docdata["date"] as Timestamp).toDate()));
        }
      }
      tasks.sort((a, b) => b.date.compareTo(a.date));
      return tasks;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> delete_all_tasks({required String email}) async {
    try {
      QuerySnapshot querydoc =
          await taskscollection.where("user", isEqualTo: email).get();
      for (QueryDocumentSnapshot x in querydoc.docs) {
        await taskscollection.doc(x.id).delete();
      }
      ;
    } catch (e) {}
  }

  Future<void> delete_task(
      {required String email, required DateTime date}) async {
    try {
      QuerySnapshot querydoc = await taskscollection
          .where("user", isEqualTo: email)
          .where("date", isEqualTo: date)
          .get();
      await taskscollection.doc(querydoc.docs.first.id).delete();
    } catch (e) {}
  }

  Future<void> finish_unfinish_task(
      {required String email,
      required DateTime date,
      required bool status}) async {
    try {
      QuerySnapshot querySnapshot = (await taskscollection
          .where(
            "user",
            isEqualTo: email,
          )
          .where("date", isEqualTo: date)
          .get());

      if (querySnapshot.docs.isNotEmpty) {
        await taskscollection
            .doc(querySnapshot.docs.first.id)
            .update({"completed": status});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update_task(
      {required String title,
      required String description,
      required String email,
      required DateTime date}) async {
    try {
      QuerySnapshot querydoc = await taskscollection
          .where("user", isEqualTo: email)
          .where("date", isEqualTo: date)
          .get();
      await taskscollection.doc(querydoc.docs.first.id).update(
          {"title": title, "description": description, "date": DateTime.now()});
    } catch (e) {}
  }
}
