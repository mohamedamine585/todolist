import 'package:flutter/material.dart';
import 'package:to_do_app/Views/Pages/Homepage.dart';
import 'package:to_do_app/Views/Pages/LoginPage.dart';
import 'package:to_do_app/Views/Pages/RegisterPage.dart';
import 'package:to_do_app/Views/Pages/TodoListPage.dart';

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
