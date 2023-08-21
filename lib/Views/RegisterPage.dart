import 'package:flutter/material.dart';
import 'package:to_do_app/Backend/Authservice.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenlength / 6,
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
                        if (password.text == cnfpassword.text) {
                          await Authservice().signup(
                              email: email.text, password: password.text);
                        }
                      },
                      child: const Text(
                        "Get Saved",
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
