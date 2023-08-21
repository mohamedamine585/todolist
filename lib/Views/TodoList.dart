import 'package:flutter/material.dart';
import 'package:to_do_app/Backend/Authservice.dart';
import 'package:to_do_app/Backend/TasksMangement.dart';

import '../consts.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late final TextEditingController filter;
  @override
  void initState() {
    filter = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                width: screenwidth * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      filter.text = query;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: "Filter by number or name",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(Icons.search),
                  ),
                )),
            SizedBox(
              height: screenlength * 0.05,
            ),
            Container(
                width: screenwidth * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed("createupdatepage", arguments: null);
                        },
                        child: const Text("Add",
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 91, 187, 199)),
                        )),
                    SizedBox(
                      width: screenwidth * 0.1,
                    ),
                    TextButton(
                        onPressed: () async {
                          await Taskmangementservice().delete_all_tasks(
                              email: Authservice().user!.email);
                        },
                        child: const Text(
                          "delete all",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 91, 187, 199)),
                        ))
                  ],
                )),
            SizedBox(
              height: screenlength * 0.05,
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              height: screenlength * 0.63,
              child: FutureBuilder(
                  future: Taskmangementservice()
                      .get_tasks(email: Authservice().user!.email),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 130, 190, 239)),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasData || snapshot.data == []) {
                        return const Column(
                          children: [
                            Text(
                              "No data",
                              style: TextStyle(fontSize: 40),
                            ),
                          ],
                        );
                      }
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data;
                              return Container(
                                width: screenwidth * 0.95,
                                height: 120,
                                child: Card(
                                  shadowColor: Colors.blue,
                                  elevation: 4,
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: screenwidth * 0.6,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text(
                                                          "Contact name :")),
                                                  Text(
                                                    data
                                                            ?.elementAt(index)
                                                            .title ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Contact log :"),
                                                  Text(
                                                    data
                                                            ?.elementAt(index)
                                                            .description ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Total call duration :")
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Last call :"),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("From device :"),
                                                  Text(
                                                    data
                                                            ?.elementAt(index)
                                                            ?.timestamp
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: screenwidth * 0.33,
                                          child: Container(
                                            width: screenwidth * 0.1,
                                            child: Checkbox(
                                                onChanged: (onchanged) {},
                                                value: false),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ));
                    } else {
                      return const Center(
                        child: Text(
                          "No data",
                          style: TextStyle(fontSize: 40),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
