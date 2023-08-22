import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/Backend/Sharedpref.dart';

import 'User.dart';

class Authservice {
  static final Authservice _instance = Authservice._();
  Authservice._();

  factory Authservice() => _instance;

  User? user;

  late final CollectionReference userscollection;
  Future<void> init() async {
    try {
      userscollection = FirebaseFirestore.instance.collection("users");
      String? email = await Sharedprefs().ProoveUserAuthentication("email");
      if (email != "" && email != null) {
        await get_user_by_rmail_only(email: email);
      }
    } catch (e) {}
  }

  Future<void> signup({required String email, required String password}) async {
    try {
      QuerySnapshot querySnapshot = await userscollection
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw Exception("user already exists");
      }
      await FirebaseFirestore.instance
          .collection("users")
          .add({"email": email, "password": password});
      user = User(email: email);
      Sharedprefs().ConfirmuserAction("email", email);
    } catch (e) {
      print(e);
      user = null;
    }
  }

  Future<void> signout() async {
    try {
      user = null;
      Sharedprefs().ConfirmuserAction("email", "");
    } catch (e) {}
  }

  Future<void> get_user_by_rmail_only({required String email}) async {
    QueryDocumentSnapshot queryDocumentSnapshot =
        (await userscollection.where("email", isEqualTo: email).get())
            .docs
            .first;
    if (queryDocumentSnapshot.exists) {
      user = User(email: email);
    }
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      QuerySnapshot querySnapshot = await userscollection
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        user = User(email: email);
        Sharedprefs().ConfirmuserAction("email", email);
      }
    } catch (e) {
      print(e);
      user = null;
    }
  }
}
