import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/controllers/home.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/ui/utils.dart';

class EventCard extends StatelessWidget {

 final  Task task;

 EventCard(this.task);

 final HomeController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: c.categories[task?.category] ??  Colors.red,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.account_balance,
                size: 150, color: Colors.black.withOpacity(.4)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.course ?? "Physics",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  task?.details ?? "Chapter 3: Force",
                  style: TextStyle(color: Colors.white70),
                ),
                YWhiteSpace(40),
                Row(
                  children: [
                    Icon(Icons.category, color: Colors.white54, size: 20),
                    XWhiteSpace(10),
                    Text(
                      task?.category ?? "Presentation",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
                YWhiteSpace(5),
                Row(
                  children: [
                    Icon(Icons.access_time_sharp,
                        color: Colors.white54, size: 20),
                    XWhiteSpace(10),
                    Text(
                      task?.startTime ?? "09:30",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
