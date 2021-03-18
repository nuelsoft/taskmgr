import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

extension core on double {
  double get ofHeight => MediaQuery.of(Get.context).size.height * this;
  double get ofWidth => MediaQuery.of(Get.context).size.width * this;
}


Widget XWhiteSpace(double width) {
  return SizedBox(width: width);
}

Widget YWhiteSpace(double height) {
  return SizedBox(height: height);
}
