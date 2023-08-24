import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';

import '../modules/User.dart';
import 'Sharedpref.dart';

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

  Future<bool> signup({required String email, required String password}) async {
    try {
      String? hash = hash_password(password: password);
      if (hash != null) {
        QuerySnapshot querySnapshot =
            await userscollection.where("email", isEqualTo: email).get();

        if (querySnapshot.docs.isNotEmpty) {
          return false;
        }
        await FirebaseFirestore.instance
            .collection("users")
            .add({"email": email, "password": hash});
        user = User(email: email);
        Sharedprefs().ConfirmuserAction("email", email);
      } else {
        user = null;
      }
    } catch (e) {
      user = null;
    }
    return true;
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
      String? hash = hash_password(password: password);
      if (hash != null) {
        QuerySnapshot querySnapshot = await userscollection
            .where("email", isEqualTo: email)
            .where("password", isEqualTo: hash)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          user = User(email: email);
          Sharedprefs().ConfirmuserAction("email", email);
        }
      } else {
        user = null;
      }
    } catch (e) {
      print(e);
      user = null;
    }
  }

  String? hash_password({required String password}) {
    try {
      return Crypt.sha256(password, rounds: 7000, salt: "have it hashed").hash;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
