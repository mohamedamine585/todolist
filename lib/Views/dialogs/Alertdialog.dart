import 'package:flutter/material.dart';

import '../../consts.dart';

AlertDialog show_alert(
    {required BuildContext context,
    required String message,
    required bool wait_response}) {
  return AlertDialog(
    title: const Text("From this app"),
    content: Text(message),
    actions: [
      (wait_response)
          ? Container(
              width: screenwidth * 0.3,
              height: 50,
              child: TextButton(
                  style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.padded,
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(218, 255, 31, 31))),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )))
          : const SizedBox(),
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
                Navigator.of(context).pop((wait_response) ? false : null);
              },
              child: Text(
                (wait_response) ? "No" : "Got it",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ))),
    ],
  );
}
