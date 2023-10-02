import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Backend/services/Authservice.dart';
import 'package:to_do_app/Backend/services/TasksMangement.dart';
import 'package:to_do_app/Views/Pages/LoginPage.dart';
import 'package:to_do_app/Views/Pages/TodoListPage.dart';
import 'package:to_do_app/consts.dart';
import 'package:to_do_app/consts.dart';
import 'package:to_do_app/firebase_options.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: all_init(context),
      builder: (context, snapshot) {
        if (user == null) {
          return const SigninPage();
        } else {
          return const TodoListPage();
        }
      },
    );
  }
}

Future<void> all_init(BuildContext context) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    screenlength = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Taskmangementservice().init();
    await Authservice().init();
  } catch (e) {}
}
