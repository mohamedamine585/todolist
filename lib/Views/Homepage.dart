import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Backend/Authservice.dart';
import 'package:to_do_app/Backend/TasksMangement.dart';
import 'package:to_do_app/Views/Alertdialog.dart';
import 'package:to_do_app/Views/LoginPage.dart';
import 'package:to_do_app/Views/TodoList.dart';
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
        if (snapshot.connectionState == ConnectionState.done) {
          if (Authservice().user == null) {
            return const SigninPage();
          } else {
            return const TodoListPage();
          }
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

Future<bool> all_init(BuildContext context) async {
  try {
    screenlength = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Taskmangementservice().init();
    await Authservice().init();
  } catch (e) {}
  return true;
}
