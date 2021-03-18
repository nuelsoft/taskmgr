import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/core/services/db.connect.dart';
import 'package:todo/ui/screens/home.dart';

class HomeController extends GetxController {
  Map<String, IconData> navigation = {
    "Home": Icons.home_outlined,
    "Tasks": Icons.list_alt,
    "Classroom": Icons.tv,
    "Chat": Icons.chat_outlined,
  };

  RxString active = "Home".obs;

  RxInt currentPage = 0.obs;

  Map<String, Color> courses = {
    "Mathematics": Colors.red,
    "Chemistry": Colors.amber,
    "Physics": Colors.blue,
  };

  RxString selectedCourse = "Mathematics".obs;

  String get today {
    DateTime now = DateTime.now();
    // return "17 September";
    final DateFormat formatter = DateFormat('MMMMd');
    return formatter.format(now);
  }

  Map<String, Color> categories = {
    "Class": Colors.green,
    "Exam": Colors.red,
    "Lab": Colors.purple,
    "Assignment": Colors.amber,
    "Presentation": Colors.blue
  };

  RxString category = "Class".obs;

  CalendarController calendarController = new CalendarController();

  RxBool loading = false.obs;

  TextEditingController detailsController = new TextEditingController();

  int hour, minute;

  RxString dateStr = "".obs;

  RxString timeStr = "".obs;

  RxString durationStr = "".obs;

  int date;
  int duration = 30;

  setDate() {
    final DateFormat formatter = DateFormat('yMMMMEEEEd');
    dateStr.value = formatter.format(DateTime.fromMillisecondsSinceEpoch(date));

    timeStr.value =
        "${hour < 9 ? '0' : ''}$hour:${minute < 9 ? '0' : ''}$minute";

    int d = duration ~/ 60;
    int m = duration - (d * 60);

    String dur = "";
    if (d > 0) dur += "$d hr ";
    dur += "${m > 0 ? ", " + m.toString() + "min" : ""}";

    durationStr.value = dur;
  }

  @override
  void onInit() {
    date = DateTime.now().millisecond;

    DateTime t = DateTime.fromMillisecondsSinceEpoch(date);

    hour = t.hour;
    minute = t.minute;
    duration = 30;

    setDate();

    // DateTime now = DateTime.now();

    // loadTasks('${now.year}${now.month}${now.day}');
    super.onInit();
  }

  Future<void> save(DateTime now) async {
    loading.value = true;

    await DatabaseService.store(new Task()
      ..duration = duration
      ..minute = minute
      ..hour = hour
      ..dayGroup = "${now.year}${now.month}${now.day}"
      ..category = category.value
      ..course = selectedCourse.value
      ..details = detailsController.text);

    // print(await DatabaseService.pull("${now.year}${now.month}${now.day}"));

    loading.value = false;
    Get.snackbar("Success", "Task saved", backgroundColor: Theme.of(Get.context).primaryColor);
  }

  RxList<Task> tasks = <Task>[].obs;

  Future<void>loadTasks(String d) async {
    loading.value = true;
    tasks.assignAll(await DatabaseService.pull(d));
    loading.value = false;
  }

// HomeController(){calendarController.setCalendarFormat(CalendarFormat.week);
// }
}
