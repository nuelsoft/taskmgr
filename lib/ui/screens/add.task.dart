import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/controllers/home.dart';
import 'package:todo/ui/crumbs/avatar.dart';
import 'package:todo/ui/crumbs/board.dart';
import 'package:todo/ui/utils.dart';

class AddTask extends StatelessWidget {
  static final uri = "/task/add";

  final HomeController c = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Form(
            key: formKey,
            child: SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Get.back(),
                  ),
                  YWhiteSpace(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Board("Hello there", "Add a Task", right: Person()),
                        YWhiteSpace(20),
                        Text(
                          "Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        YWhiteSpace(10),
                        Obx(() => Wrap(
                              children: [
                                for (String category in c.categories.keys)
                                  GestureDetector(
                                    onTap: () {
                                      c.category.value = category;
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      decoration: BoxDecoration(
                                        boxShadow: c.category.value == category
                                            ? [
                                                BoxShadow(
                                                    color: c
                                                        .categories[category]
                                                        .withOpacity(.25),
                                                    spreadRadius: 4,
                                                    blurRadius: 10)
                                              ]
                                            : [],
                                        color: c.categories[category]
                                            .withOpacity(
                                                c.category.value == category
                                                    ? 1
                                                    : .5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  )
                              ],
                            )),
                        YWhiteSpace(30),
                        DropdownButtonFormField(
                          items: [
                            for (String course in c.courses.keys)
                              DropdownMenuItem(
                                child: Text(course),
                                value: course,
                              )
                          ],
                          value: c.selectedCourse.value,
                          onChanged: (n) {
                            c.selectedCourse.value = n;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                          ),
                        ),
                        YWhiteSpace(20),
                        TextFormField(
                          controller: c.detailsController,
                          validator: (v) =>
                              v.isEmpty ? "You can't leave empty" : null,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.note),
                            hintText: "Topic/Chapter Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                          ),
                        ),
                        YWhiteSpace(20),
                        Row(
                          children: [
                            buildBox(Icon(Icons.calendar_today,
                                color: Colors.grey.shade600)),
                            InkWell(
                              onTap: () async {
                                DateTime dt = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 365)),
                                    initialDate: DateTime.now());

                                c.date = dt.millisecondsSinceEpoch;
                                c.setDate();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Obx(
                                    () => Text(c.dateStr.value),
                                  )),
                            )
                          ],
                        ),
                        YWhiteSpace(20),
                        Row(
                          children: [
                            Row(
                              children: [
                                buildBox(Icon(Icons.access_time_sharp,
                                    color: Colors.grey.shade600)),
                                InkWell(
                                  onTap: () async {
                                    TimeOfDay d = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: c.hour, minute: c.minute));
                                    c.hour = d.hour;
                                    c.minute = d.minute;

                                    c.setDate();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Obx(() => Text(c.timeStr.value)),
                                  ),
                                )
                              ],
                            ),
                            XWhiteSpace(20),
                            Row(
                              children: [
                                buildBox(Icon(Icons.timelapse_rounded,
                                    color: Colors.grey.shade600)),
                                InkWell(
                                  onTap: () async {
                                    Duration d = await showDurationPicker(
                                        context: context,
                                        initialTime: Duration(
                                            hours: 0, minutes: c.duration));
                                    c.duration = d.inMinutes;
                                    c.setDate();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Obx(() => Text(c.durationStr.value)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        YWhiteSpace(20),
                        YWhiteSpace(50),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(() => CupertinoButton.filled(
                                    child: c.loading.value
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "Add Task",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold),
                                          ),
                                    onPressed: c.loading.value
                                        ? null
                                        : () {
                                            if (formKey.currentState
                                                .validate()) {
                                              DateTime d = DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      c.date);
                                              c.save(d);
                                            }
                                          },
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget buildBox(Icon icon) {
    return Container(
      child: icon,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.05),
                spreadRadius: 10,
                blurRadius: 8)
          ]),
    );
  }
}
