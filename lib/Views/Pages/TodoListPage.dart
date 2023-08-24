import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:to_do_app/Backend/services/Authservice.dart';
import 'package:to_do_app/Backend/modules/Task.dart';
import 'package:to_do_app/Backend/services/TasksMangement.dart';
import 'package:to_do_app/Views/dialogs/Alertdialog.dart';
import 'package:to_do_app/Views/Pages/CreateOrUpdateTask.dart';
import 'package:to_do_app/consts.dart';

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

  final tasksmangementservice = Taskmangementservice();
  final authservice = Authservice();
  List<Task> data = [];
  bool should_reload = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Container(
            width: screenwidth * 0.1,
            child: IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () async {
                final should_delete = await showDialog(
                    context: context,
                    builder: (context) => show_alert(
                        context: context,
                        message: "Do you want to delete all tasks ?",
                        wait_response: true));

                if (should_delete) {
                  await tasksmangementservice.delete_all_tasks(
                      email: authservice.user!.email);
                  setState(() {});
                }
              },
            ),
          ),
          Container(
            width: screenwidth * 0.1,
            child: IconButton(
                onPressed: () async {
                  await authservice.signout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("signinpage", (route) => false);
                },
                icon: const Icon(Icons.logout)),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: screenwidth * 0.35,
            ),
            const Text(
              "Tasks",
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
                height: screenlength * 0.05,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      filter.text = query;
                      should_reload = true;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: "Filter by title",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(Icons.search),
                  ),
                )),
            SizedBox(
              height: screenlength * 0.01,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenlength * 0.005,
            ),
            Container(
              height: screenlength * 0.77,
              child: StreamBuilder(
                  stream: (should_reload)
                      ? tasksmangementservice.get_tasks(
                          email: authservice.user!.email)
                      : null,
                  builder: (context, snapshot) {
                    (should_reload)
                        ? data = (snapshot.data
                                ?.where((element) =>
                                    element.title.contains(filter.text))
                                .toList() ??
                            [])
                        : data;

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 130, 190, 239)),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.none) {
                      if (snapshot.data?.isEmpty ?? true) {
                        return Column(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Createupdatetasks()));
                              },
                              child: const Icon(Icons.add),
                            ),
                            SizedBox(
                              height: screenlength * 0.2,
                            ),
                            Container(
                              child: Text(
                                "No Tasks",
                                style: TextStyle(fontSize: 40),
                              ),
                            )
                          ],
                        );
                      }
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              should_reload = true;
                            });
                          },
                          child: Column(
                            children: [
                              (data.isNotEmpty)
                                  ? GFProgressBar(
                                      percentage: tasksmangementservice
                                          .completed_task(tasks: data),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: screenwidth * 0.05,
                              ),
                              Container(
                                height: screenlength * 0.05,
                                child: FloatingActionButton(
                                  backgroundColor:
                                      Color.fromARGB(255, 88, 197, 240),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Createupdatetasks()));
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: screenwidth * 0.95,
                                      height: screenlength * 0.3,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Createupdatetasks(
                                                        title_text: data
                                                            .elementAt(index)
                                                            .title,
                                                        description_text: data
                                                            .elementAt(index)
                                                            .description,
                                                        date: data
                                                            .elementAt(index)
                                                            .date,
                                                      )));
                                        },
                                        child: Card(
                                          shadowColor: Colors.blue,
                                          elevation: 4,
                                          child: SingleChildScrollView(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsetsDirectional
                                                      .only(
                                                          start: screenwidth *
                                                              0.05),
                                                  width: screenwidth * 0.6,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        width:
                                                            screenwidth * 0.6,
                                                        child: Text(
                                                          data
                                                              .elementAt(index)
                                                              .title,
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenlength * 0.05,
                                                      ),
                                                      Container(
                                                        width:
                                                            screenwidth * 0.6,
                                                        child: Text(
                                                          data
                                                              .elementAt(index)
                                                              .description,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenlength * 0.05,
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: screenwidth *
                                                                0.2,
                                                            child: Text(
                                                              data
                                                                  .elementAt(
                                                                      index)
                                                                  .date
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: screenwidth *
                                                                0.4,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: screenwidth * 0.21,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                          onChanged:
                                                              (onchanged) async {
                                                            await tasksmangementservice
                                                                .finish_unfinish_task(
                                                                    email: authservice
                                                                        .user!
                                                                        .email,
                                                                    date: data
                                                                        .elementAt(
                                                                            index)
                                                                        .date,
                                                                    status:
                                                                        onchanged!);
                                                          },
                                                          value: data[index]
                                                              .completed),
                                                      SizedBox(
                                                        width: screenwidth *
                                                            0.0001,
                                                      ),
                                                      Text(
                                                        (data
                                                                .elementAt(
                                                                    index)
                                                                .completed)
                                                            ? "done"
                                                            : "doing",
                                                        style: (data
                                                                .elementAt(
                                                                    index)
                                                                .completed)
                                                            ? const TextStyle(
                                                                color:
                                                                    Colors.blue)
                                                            : null,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: screenwidth * 0.1,
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        await tasksmangementservice
                                                            .delete_task(
                                                                email:
                                                                    authservice
                                                                        .user!
                                                                        .email,
                                                                date: data
                                                                    .elementAt(
                                                                        index)
                                                                    .date);
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ));
                    } else {
                      return Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Icon(Icons.refresh),
                          ),
                          SizedBox(
                            height: screenlength * 0.2,
                          ),
                          Container(
                            child: Text(
                              "No Tasks",
                              style: TextStyle(fontSize: 40),
                            ),
                          )
                        ],
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
