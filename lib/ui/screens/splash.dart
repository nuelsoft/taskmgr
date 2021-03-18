import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/controllers/home.dart';
import 'package:todo/core/services/db.connect.dart';
import 'package:todo/ui/screens/home.nav.dart';
import 'package:todo/ui/utils.dart';

class SplashScreen extends StatefulWidget {
  static final String uri = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    DatabaseService.connect().then((value) {
      HomeController c = Get.find();
      DateTime now = DateTime.now();
      c
          .loadTasks('${now.year}${now.month}${now.day}')
          .then((value) => Get.offAndToNamed("/home"));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Splash Screen",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text("Hello there 👋🏽"),
          YWhiteSpace(30),
          CircularProgressIndicator()
        ],
      ),
    )));
  }
}
