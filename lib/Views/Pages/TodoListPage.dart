import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Backend/modules/Days.dart';
import 'package:to_do_app/Backend/providers/days_provider.dart';
import 'package:to_do_app/Backend/services/Authservice.dart';
import 'package:to_do_app/Backend/modules/Task.dart';
import 'package:to_do_app/Backend/services/TasksMangement.dart';
import 'package:to_do_app/Backend/usefulfunctions.dart';
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
  bool should_reload = true, should_reload_days = true;

  @override
  Widget build(BuildContext context) {
    DateTime selected_day = DateTime.now();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 239, 241),
      appBar: AppBar(
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
        backgroundColor: Color.fromARGB(255, 227, 239, 241),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenlength * 0.77,
              width: screenwidth * 0.99,
              child: ChangeNotifierProvider(
                create: (context) =>
                    days_provider(oldest: genereate_olddays(tasks: data)),
                child: StreamBuilder(
                    stream: (should_reload)
                        ? tasksmangementservice.get_tasks(email: user!.email)
                        : null,
                    builder: (context, snapshot) {
                      (should_reload)
                          ? data = snapshot.data?.toList() ?? []
                          : data;

                      ScrollController scrollController = ScrollController();
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
                              Container(
                                width: screenwidth * 0.99,
                                height: screenlength * 0.15,
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: Provider.of<days_provider>(context)
                                          .days
                                          ?.length ??
                                      0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context0, index) {
                                    return Container(
                                      width: screenwidth * 0.2,
                                      height: screenlength * 0.15,
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<days_provider>()
                                              .select_day(index: index);
                                        },
                                        child: Card(
                                          color: (Provider.of<days_provider>(
                                                      context)
                                                  .days!
                                                  .elementAt(index)
                                                  .is_selected)
                                              ? Color.fromARGB(
                                                  255, 83, 106, 223)
                                              : null,
                                          elevation: 9,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: screenlength * 0.01,
                                              ),
                                              Text(
                                                "${Provider.of<days_provider>(context).days!.elementAt(index).date.day}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${Provider.of<days_provider>(context).days!.elementAt(index).date.month}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${Provider.of<days_provider>(context).days!.elementAt(index).date.year}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Divider(
                                thickness: 0.9,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Createupdatetasks(
                                                title_text: null,
                                                description_text: null,
                                                date: selected_day,
                                              )));
                                },
                                child: const Icon(Icons.add),
                              )
                            ],
                          );
                        }
                        try {
                          return RefreshIndicator(
                              onRefresh: () async {
                                setState(() {
                                  should_reload = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: screenwidth * 0.99,
                                    height: screenlength * 0.15,
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount:
                                          Provider.of<days_provider>(context)
                                                  .days
                                                  ?.length ??
                                              0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context0, index) {
                                        return Container(
                                          width: screenwidth * 0.2,
                                          height: screenlength * 0.15,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<days_provider>()
                                                  .select_day(index: index);
                                              selected_day =
                                                  Provider.of<days_provider>(
                                                          context,
                                                          listen: false)
                                                      .days!
                                                      .elementAt(index)
                                                      .date;
                                            },
                                            child: Card(
                                              color:
                                                  (Provider.of<days_provider>(
                                                              context)
                                                          .days!
                                                          .elementAt(index)
                                                          .is_selected)
                                                      ? Color.fromARGB(
                                                          255, 120, 167, 238)
                                                      : null,
                                              elevation: 9,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenlength * 0.01,
                                                  ),
                                                  Text(
                                                    "${Provider.of<days_provider>(context).days!.elementAt(index).date.day}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${months[(Provider.of<days_provider>(context).days!.elementAt(index).date.month)]}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${Provider.of<days_provider>(context).days!.elementAt(index).date.year}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenlength * 0.05,
                                  ),
                                  (data.isNotEmpty)
                                      ? GFProgressBar(
                                          percentage: tasksmangementservice
                                              .completed_task(tasks: data),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: screenlength * 0.01,
                                  ),
                                  FloatingActionButton(
                                    backgroundColor:
                                        Color.fromARGB(255, 120, 167, 238),
                                    onPressed: () {
                                      print("${selected_day.day}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Createupdatetasks(
                                                    title_text: null,
                                                    description_text: null,
                                                    date: selected_day,
                                                  )));
                                    },
                                    child: const Icon(
                                      Icons.add,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        Day? dday;
                                        dday =
                                            Provider.of<days_provider>(context)
                                                .days!
                                                .firstWhere((element) =>
                                                    element.is_selected);

                                        if (data.elementAt(index).date.day ==
                                                dday.date.day &&
                                            data.elementAt(index).date.month ==
                                                dday.date.month) {
                                          return Container(
                                            width: screenwidth * 0.95,
                                            height: screenlength * 0.25,
                                            child: GestureDetector(
                                              onHorizontalDragEnd:
                                                  (dranenddetails) {
                                                print("ez");
                                              },
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Createupdatetasks(
                                                              title_text: data
                                                                  .elementAt(
                                                                      index)
                                                                  .title,
                                                              description_text: data
                                                                  .elementAt(
                                                                      index)
                                                                  .description,
                                                              date: data
                                                                  .elementAt(
                                                                      index)
                                                                  .date,
                                                            )));
                                              },
                                              child: Draggable(
                                                axis: Axis.horizontal,
                                                feedback: Card(
                                                  shadowColor: Colors.blue,
                                                  elevation: 4,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsetsDirectional
                                                            .only(
                                                                start:
                                                                    screenwidth *
                                                                        0.05),
                                                        width:
                                                            screenwidth * 0.6,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenwidth *
                                                                        0.6,
                                                                child: Text(
                                                                  data
                                                                      .elementAt(
                                                                          index)
                                                                      .title,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                              ),
                                                              const Divider(
                                                                thickness: 1,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenlength *
                                                                        0.05,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenwidth *
                                                                        0.6,
                                                                child: Text(
                                                                  data
                                                                      .elementAt(
                                                                          index)
                                                                      .description,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenlength *
                                                                        0.05,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            screenwidth * 0.3,
                                                        child: Row(
                                                          children: [
                                                            Checkbox(
                                                                activeColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        120,
                                                                        167,
                                                                        238),
                                                                onChanged:
                                                                    (onchanged) async {
                                                                  await tasksmangementservice.finish_unfinish_task(
                                                                      email: user!
                                                                          .email,
                                                                      date: data
                                                                          .elementAt(
                                                                              index)
                                                                          .date,
                                                                      status:
                                                                          onchanged!);
                                                                },
                                                                value: data[
                                                                        index]
                                                                    .completed),
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
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          120,
                                                                          167,
                                                                          238))
                                                                  : null,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onDragEnd: (d) {
                                                  if (d.velocity.pixelsPerSecond
                                                              .direction ==
                                                          0 &&
                                                      d.velocity.pixelsPerSecond
                                                              .distanceSquared >
                                                          200) {
                                                    print("object");
                                                  }
                                                },
                                                child: Card(
                                                  shadowColor: Colors.blue,
                                                  elevation: 4,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsetsDirectional
                                                            .only(
                                                                start:
                                                                    screenwidth *
                                                                        0.05),
                                                        width:
                                                            screenwidth * 0.6,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenwidth *
                                                                        0.6,
                                                                child: Text(
                                                                  data
                                                                      .elementAt(
                                                                          index)
                                                                      .title,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                              ),
                                                              const Divider(
                                                                thickness: 1,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenlength *
                                                                        0.05,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenwidth *
                                                                        0.6,
                                                                child: Text(
                                                                  data
                                                                      .elementAt(
                                                                          index)
                                                                      .description,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenlength *
                                                                        0.05,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            screenwidth * 0.3,
                                                        child: Row(
                                                          children: [
                                                            Checkbox(
                                                                activeColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        120,
                                                                        167,
                                                                        238),
                                                                onChanged:
                                                                    (onchanged) async {
                                                                  await tasksmangementservice.finish_unfinish_task(
                                                                      email: user!
                                                                          .email,
                                                                      date: data
                                                                          .elementAt(
                                                                              index)
                                                                          .date,
                                                                      status:
                                                                          onchanged!);
                                                                },
                                                                value: data[
                                                                        index]
                                                                    .completed),
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
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          120,
                                                                          167,
                                                                          238))
                                                                  : null,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ));
                        } catch (e) {
                          return RefreshIndicator(
                              onRefresh: () async {
                                setState(() {
                                  should_reload = true;
                                });
                              },
                              child: SizedBox());
                        }
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
            ),
          ],
        ),
      ),
    );
  }
}
