import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app/Backend/modules/User.dart';
import 'package:to_do_app/Backend/services/Authservice.dart';

class Mockauth extends Mock implements Authservice {
  static final Mockauth _instance = Mockauth._();
  Mockauth._();

  factory Mockauth() => _instance;
  late final CollectionReference userscollection;
  User? user;
  @override
  String? hash_password({required String password}) {
    return Authservice().hash_password(password: password);
  }

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
    userscollection = FirebaseFirestore.instance.collection("users");
  }

  @override
  Future<bool> signup({required String email, required String password}) async {
    try {
      String? hash = hash_password(password: password);
      if (hash != null) {
        QuerySnapshot querySnapshot =
            await userscollection.where("email", isEqualTo: email).get();

        if (querySnapshot.docs.isNotEmpty) {
          return false;
        }
        await userscollection.add({"email": email, "password": hash});
        user = User(email: email);
      } else {
        user = null;
      }
    } catch (e) {
      user = null;
    }
    return true;
  }

  @override
  Future<void> signin({required String email, required String password}) async {
    try {
      final hash = hash_password(password: password);
      if (hash != null) {
        QuerySnapshot querySnapshot = await userscollection
            .where("email", isEqualTo: email)
            .where("password", isEqualTo: hash)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          user = User(email: email);
        }
      } else {
        user = null;
      }
    } catch (e) {
      print(e);
      user = null;
    }
  }
}

class Fakeauth extends Fake implements Authservice {
  static final Fakeauth _instance = Fakeauth._();
  Fakeauth._();

  factory Fakeauth() => _instance;
  late final CollectionReference userscollection;
  User? user;
  @override
  String? hash_password({required String password}) {
    return Authservice().hash_password(password: password);
  }

  @override
  Future<void> init() async {
    final app = FakeFirebaseFirestore();
    userscollection = app.collection("users");
  }

  @override
  Future<bool> signup({required String email, required String password}) async {
    try {
      String? hash = hash_password(password: password);
      if (hash != null) {
        QuerySnapshot querySnapshot =
            await userscollection.where("email", isEqualTo: email).get();

        if (querySnapshot.docs.isNotEmpty) {
          return false;
        }
        await userscollection.add({"email": email, "password": hash});
        user = User(email: email);
      } else {
        user = null;
      }
    } catch (e) {
      user = null;
    }
    return true;
  }

  @override
  Future<void> signin({required String email, required String password}) async {
    try {
      final hash = hash_password(password: password);
      if (hash != null) {
        QuerySnapshot querySnapshot = await userscollection
            .where("email", isEqualTo: email)
            .where("password", isEqualTo: hash)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          user = User(email: email);
        }
      } else {
        user = null;
      }
    } catch (e) {
      print(e);
      user = null;
    }
  }
}

void main() {
  setUp(() async {
    await Firebase.initializeApp();
  });
  test('correct email and password', () async {
    await Mockauth().init();
    await Mockauth().signup(email: "foxweb585@gmail.com", password: "medamine");
    await Mockauth().signin(email: "foxweb585@gmail.com", password: "medamine");
    expect(Mockauth().user?.email, "foxweb585@gmail.com");
  });
}
