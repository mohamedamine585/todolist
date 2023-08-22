import 'package:flutter/material.dart';

import '../consts.dart';

AlertDialog show_alert(
    {required BuildContext context, required String message}) {
  return AlertDialog(
    title: const Text("From this app"),
    content: Text(message),
    actions: [
      Container(
          width: screenwidth * 0.3,
          height: 50,
          child: TextButton(
              style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.padded,
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(218, 182, 228, 240))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Got it",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ))),
    ],
  );
}
