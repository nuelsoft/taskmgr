import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/core/controllers/home.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/ui/crumbs/board.dart';
import 'package:todo/ui/crumbs/event.card.dart';
import 'package:todo/ui/screens/add.task.dart';

import '../utils.dart';

class TaskScreen extends StatelessWidget {
  final HomeController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Board(c.today, "Today",
                            right: CupertinoButton.filled(
                                borderRadius: BorderRadius.circular(20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                child: Text("Add Task"),
                                onPressed: () {
                                  Get.toNamed(AddTask.uri).then((value) {
                                    DateTime now = DateTime.now();
                                    return c.loadTasks('${now.year}${now.month}${now.day}');
                                  });
                                })),
                        YWhiteSpace(10),
                        TableCalendar(
                          calendarController: c.calendarController,
                          initialCalendarFormat: CalendarFormat.week,
                          headerStyle: HeaderStyle(
                            centerHeaderTitle: false,
                            formatButtonVisible: false,
                          ),
                          onDaySelected: (day, _, __) {
                            c.loadTasks("${day.year}${day.month}${day.day}");
                          },
                          onCalendarCreated: (_, __, n) {
                            DateTime now = DateTime.now();
                            c.loadTasks("${now.year}${now.month}${now.day}");
                          },
                          calendarStyle: CalendarStyle(
                            selectedColor: Theme.of(context).accentColor,
                            todayColor:
                                Theme.of(context).accentColor.withOpacity(.4),
                            weekendStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        YWhiteSpace(20),
                        Obx(
                          () => c.loading.value
                              ? Center(child: CircularProgressIndicator())
                              : SizedBox(height: 0, width: 0),
                        ),

                        Obx(() => !c.loading.value && c.tasks.isEmpty
                            ? Center(child: Text("No Tasks Today"))
                            : SizedBox(height: 0, width: 0)),

                        Obx(() => Column(children: [
                              for (Task t in c.tasks)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            t.startTime,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            t.endTime,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      XWhiteSpace(30),
                                      Column(
                                        children: [
                                          Icon(Icons.center_focus_strong,
                                              color: Colors.grey),
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            width: 10,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            height: 150,
                                          )
                                        ],
                                      ),
                                      XWhiteSpace(10),
                                      Expanded(child: EventCard(t))
                                    ],
                                  ),
                                )
                            ]))

                        // YWhiteSpace(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            YWhiteSpace(100)
          ]),
    );
  }
}
