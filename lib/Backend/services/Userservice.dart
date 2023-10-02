import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/Backend/modules/Group.dart';
import 'package:to_do_app/Backend/modules/Grouptask.dart';
import 'package:to_do_app/consts.dart';

class Userservice {
  static final Userservice _instance = Userservice._();
  Userservice._();

  factory Userservice() => _instance;

  Future<void> enter_group({required String groupid}) async {
    try {
      DocumentSnapshot group = await groupscollection!.doc(groupid).get();

      QuerySnapshot querySnapshot = await grouptaskscollection!
          .where("group_id", isEqualTo: group.id)
          .get();
      querySnapshot.docs.forEach((element) async {
        await grouptaskscollection!.doc(element.id).update({
          "completed": (element.data() as dynamic)["completed"] + [false]
        });
      });
      await groupscollection!.doc(groupid).update({
        "users": (group.data() as dynamic)["users"] + [user!.id],
        "non_viewed_tasks": (group.data() as dynamic)["non_viewed_tasks"] +
            [querySnapshot.docs.length]
      });

      await userscollection!.doc(user!.id).update({
        "groups": user!.groups! + [group.id]
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> add_group_task(
      {required String title,
      required String description,
      required Timestamp end,
      required Group group}) async {
    try {
      final comps = List.generate(group.users.length, (index) {
        return false;
      });
      await grouptaskscollection!.add({
        "group_id": group.id,
        "title": title,
        "description": description,
        "completed": comps,
        "start_date": Timestamp.now(),
        "finish_date": end,
        "creator_id": user!.id,
        "comments": [],
        "likes": 0,
        "dislikes": 0
      });
      group.non_viewed_tasks.forEach((element) {
        element++;
      });
      await groupscollection!
          .doc(group.id)
          .update({"non_viewed_tasks": group.non_viewed_tasks});
    } catch (e) {
      print(e);
    }
  }

  Future<void> remove_group_task(
      {required String task_id, required Group group}) async {
    try {
      await grouptaskscollection!.doc(task_id).delete();
      group.non_viewed_tasks.forEach((element) {
        element--;
      });
      await groupscollection!
          .doc(group.id)
          .update({"non_viewed_tasks": group.non_viewed_tasks});
    } catch (e) {
      print(e);
    }
  }

  Future<void> update_group_task(
      {required String task_id,
      required String title,
      required Timestamp finish,
      required String description,
      required Group group}) async {
    try {
      ////         *      *              * notify user ///////////////////////////////
      await grouptaskscollection!.doc(task_id).update(
          {"title": title, "description": description, "finish_date": finish});
    } catch (e) {
      print(e);
    }
  }

  Future<void> quit_group({required Group group}) async {
    try {
      QuerySnapshot querySnapshot = await grouptaskscollection!
          .where("group_id", isEqualTo: group.id)
          .get();

      querySnapshot.docs.forEach((element) async {
        List<bool> comps = (element.data() as dynamic)["completed"];
        comps.removeAt(group.users.indexOf(user!.email));
        await grouptaskscollection!
            .doc(element.id)
            .update({"completed": comps});
      });
      group.non_viewed_tasks.remove(user!.id);

      group.users.removeWhere((element) => element == user!.id);
      await groupscollection!.doc(group.id).update(
          {"users": group.users, "non_viewed_tasks": group.non_viewed_tasks});

      await userscollection!.doc(user!.id).update({
        "groups": user!.groups! + [group.id]
      });
    } catch (e) {
      print(e);
    }
  }
}
