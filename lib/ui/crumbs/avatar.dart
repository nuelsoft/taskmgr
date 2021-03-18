import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  final Function onTap;

  Person({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Icon(Icons.person, size: 35, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
