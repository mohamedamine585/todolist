import 'package:flutter/material.dart';

import '../../Backend/services/Authservice.dart';
import '../../Backend/services/TasksMangement.dart';
import '../../consts.dart';

class Createupdatetasks extends StatefulWidget {
  String? title_text, description_text;
  DateTime? date;
  Createupdatetasks(
      {super.key, this.description_text, this.title_text, this.date});

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
    final taskmangementservice = Taskmangementservice();
    final authservice = Authservice();
    var time;
    final title_txt = widget.title_text,
        description_text = widget.description_text,
        date = widget.date;
    if (title_txt != null && description_text != null) {
      title.text = title_txt;
      description.text = description_text;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 239, 241),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: screenwidth * 0.1,
            ),
            Text(
              (title_txt == null && description_text == null)
                  ? "Add a Task"
                  : "Update Task",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 227, 239, 241),
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
                        "Title",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  maxLines: null,
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
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.86,
                child: TextField(
                  maxLines: null,
                  controller: description,
                  style: const TextStyle(height: 2, fontSize: 20),
                ),
              ),
              SizedBox(
                height: screenlength / 20,
              ),
              Container(
                height: screenlength * 0.2,
                child: FloatingActionButton(
                    child: const Icon(Icons.timer),
                    onPressed: () async {
                      time = await showDialog(
                        context: context,
                        builder: (context) => Container(
                          height: screenlength * 0.2,
                          child: TimePickerDialog(
                            initialTime: TimeOfDay.now(),
                            onEntryModeChanged: (time) {
                              Navigator.pop<TimePickerEntryMode>(context, time);
                            },
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                width: screenwidth * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            onPressed: () async {
                              if (title_txt != null &&
                                  description_text != null &&
                                  date != null) {
                                await taskmangementservice.update_task(
                                    title: title.text,
                                    description: description.text,
                                    email: user!.email,
                                    date: date,
                                    deadline: time);
                              } else {
                                await taskmangementservice.add_task(
                                    deadline: time,
                                    title: title.text,
                                    description: description.text,
                                    email: user!.email,
                                    date: date ?? DateTime.now());
                              }

                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              "Save",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
