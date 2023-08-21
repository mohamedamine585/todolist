import 'package:flutter/material.dart';

import '../consts.dart';

class Createupdatetasks extends StatefulWidget {
  const Createupdatetasks({super.key});

  @override
  State<Createupdatetasks> createState() => _CreateupdatetasksState();
}

class _CreateupdatetasksState extends State<Createupdatetasks> {
  late final TextEditingController title;
  late final TextEditingController description;
  @override
  void initState() {
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(
              width: 90,
            ),
            const Text(
              "To do List",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenlength / 13,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  Column(
                    children: [
                      Text(
                        "title",
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
                  controller: title,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 2,
                  ),
                ),
              ),
              SizedBox(
                height: screenlength / 70,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  const Column(
                    children: [
                      Text(
                        "description",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.86,
                child: TextField(
                  controller: description,
                  obscureText: true,
                  style: const TextStyle(height: 2, fontSize: 20),
                ),
              ),
              SizedBox(
                height: screenlength / 20,
              ),
              Row(
                children: [
                  Container(
                      width: screenwidth * 0.3,
                      height: 50,
                      child: TextButton(
                          style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.padded,
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(218, 94, 227, 250))),
                          onPressed: () async {},
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ))),
                  Container(
                      width: screenwidth * 0.3,
                      height: 50,
                      child: TextButton(
                          style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.padded,
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(218, 182, 228, 240))),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "Register", (route) => false);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
