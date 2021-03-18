import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/controllers/home.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/ui/crumbs/avatar.dart';
import 'package:todo/ui/crumbs/board.dart';
import 'package:todo/ui/crumbs/event.card.dart';

import '../utils.dart';

class Home extends StatelessWidget {
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
                        Obx(() => Board("Hello there", "You've got",
                            bottom: "${c.tasks.length} Tasks Today",
                            right: Person())),
                        YWhiteSpace(40),
                        Text(
                          "Courses",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Your Running subjects",
                          style: TextStyle(color: Colors.grey),
                        ),
                        // YWhiteSpace(10),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (String title in c.courses.keys)
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  width: .45.ofWidth,
                                  decoration: BoxDecoration(
                                      color: c.courses[title],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.book_sharp,
                                            color: Colors.white.withOpacity(.5),
                                            size: 40),
                                        YWhiteSpace(20),
                                        Text(
                                          title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                  )))
                      ],
                    ),
                  ),
                  YWhiteSpace(10),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Schedule",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Upcoming classes and tasks",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 200,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (Task t in c.tasks)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: EventCard(t),
                              )
                          ],
                        ),
                      )),
                  YWhiteSpace(150),
                ],
              ),
            ),
          ]),
    );
  }
}
