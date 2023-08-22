import 'package:flutter/material.dart';
import 'package:to_do_app/Views/Homepage.dart';
import 'package:to_do_app/Views/LoginPage.dart';
import 'package:to_do_app/Views/RegisterPage.dart';
import 'package:to_do_app/Views/TodoList.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "homepage": (context) => const HomePage(),
      "todolistpage": (context) => const TodoListPage(),
      "signinpage": (context) => const SigninPage(),
      "signuppage": (context) => const RegisterPage()
    },
    home: const HomePage(),
  ));
}
