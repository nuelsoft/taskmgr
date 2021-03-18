import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/controllers/home.dart';
import 'package:todo/ui/crumbs/avatar.dart';
import 'package:todo/ui/crumbs/board.dart';
import 'package:todo/ui/crumbs/nav.dart';
import 'package:todo/ui/screens/home.dart';
import 'package:todo/ui/screens/task.dart';
import 'package:todo/ui/screens/unimplemented.dart';
import 'package:todo/ui/utils.dart';

class HomeNavigator extends StatelessWidget {
  static final String uri = "/home";

  final HomeController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Obx(() => IndexedStack(
              children: [
                Home(),
                TaskScreen(),
                UnImplemented(),
                UnImplemented()
              ],
              index: c.currentPage.value,
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.4),
                    spreadRadius: 5,
                    blurRadius: 20)
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            child: Obx(() => CustomNav(
                  options: [
                    for (String key in c.navigation.keys)
                      CustomNavItem(
                        icon: c.navigation[key],
                        text: key,
                        active: key == c.active.value,
                        onTap: () {
                          c.active.value = key;
                          c.currentPage.value =
                              c.navigation.keys.toList().indexOf(key);
                        },
                      )
                  ],
                )),
          ),
        )
      ],
    ));
  }
}
