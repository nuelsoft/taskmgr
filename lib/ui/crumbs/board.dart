import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/ui/crumbs/avatar.dart';

class Board extends StatelessWidget {
  final String top;
  final String middle;
  final String bottom;
  final Widget right;

  Board(this.top, this.middle, {this.bottom, this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                top,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                middle,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 25),
              ),
              if (bottom != null)
                Text(
                  bottom,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Theme.of(context).accentColor),
                )
            ],
          ),
          if(this.right != null)
          right
        ],
      ),
    );
  }
}
