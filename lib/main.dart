import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/__init.dart';
import 'package:todo/ui/screens/add.task.dart';
import 'package:todo/ui/screens/home.nav.dart';
import 'package:todo/ui/screens/splash.dart';

void main() {
  initialize();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.poppinsTextTheme()),
      routes: {
        SplashScreen.uri: (context) => SplashScreen(),
        HomeNavigator.uri: (context) => HomeNavigator(),
        AddTask.uri: (context) => AddTask()
      },
      home: SplashScreen(),
    );
  }
}
