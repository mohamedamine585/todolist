import 'package:flutter/material.dart';
import 'package:to_do_app/Backend/Authservice.dart';
import 'package:to_do_app/Backend/Devicesystem.dart';
import 'package:to_do_app/Views/Alertdialog.dart';

import '../consts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController cnfpassword;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    cnfpassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    cnfpassword.dispose();
    super.dispose();
  }

  final authservice = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenlength * 0.1,
              ),
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: screenwidth * 0.86,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: email,
                  style: TextStyle(
                    height: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.86,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  style: const TextStyle(
                    height: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.86,
                child: TextField(
                  controller: cnfpassword,
                  obscureText: true,
                  style: TextStyle(
                    height: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.padded,
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(218, 94, 227, 250))),
                      onPressed: () async {
                        final conn = await Devicesystem().check_coonection();
                        if (!conn) {
                          showDialog(
                              context: context,
                              builder: (context) => show_alert(
                                  context: context,
                                  message: "Check connection"));
                        } else {
                          if (email.text != "" && password.text != "") {
                            if (password.text == cnfpassword.text) {
                              final what_happend = await authservice.signup(
                                  email: email.text, password: password.text);
                              if (authservice.user == null) {
                                if (what_happend == false) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => show_alert(
                                          context: context,
                                          message:
                                              "User already exists with those Credentials"));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => show_alert(
                                          context: context,
                                          message: "Sign up failed"));
                                }
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "todolistpage", (route) => false);
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => show_alert(
                                      context: context,
                                      message: "Passwords doesn't match"));
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => show_alert(
                                    context: context,
                                    message: "Inacceptable email or password"));
                          }
                        }
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ))),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.padded,
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(218, 182, 228, 240))),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "signinpage", (route) => false);
                      },
                      child: const Text(
                        "I'm already in",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
