import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/Backend/modules/Group.dart';
import 'package:to_do_app/consts.dart';

class GroupService {
  static final GroupService _instance = GroupService._();
  GroupService._();

  factory GroupService() => _instance;

  Group? group;

  Future<void> create_group({required String name}) async {
    try {
      await groupscollection!.add({
        "name": name,
        "admins": [user!.id],
        "founder": user!.id,
        "users": [user!.id],
        "non_viewed_tasks": [],
        "created_at": Timestamp.now(),
        "image_url": ""
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete_group() async {
    try {
      await groupscollection!.doc(group!.id).delete();
      // delete image ///////
      ////
      (await grouptaskscollection!
              .where("group_id", isEqualTo: group!.id)
              .get())
          .docs
          .forEach((element) async {
        await grouptaskscollection!.doc(element.id).delete();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> update_group_name({required String newname}) async {
    try {
      await groupscollection!.doc(group!.id).update({"name": newname});
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete_user({required String userid}) async {
    try {
      final users = group!.users;
      final admins = group!.admins;
      users.remove(userid);
      admins.remove(userid);
      await groupscollection!
          .doc(group!.id)
          .update({"users": users, "admins": admins});
      final user = await userscollection!.doc(userid).get();
      final user_groups = (user.data() as dynamic)["groups"] as List<dynamic>;
      user_groups.remove(group!.id);
      await userscollection!.doc(user.id).update({"groups": user_groups});
    } catch (e) {
      print(e);
    }
  }
}
