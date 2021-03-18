import 'package:flutter/material.dart';
import 'package:todo/ui/utils.dart';

class CustomNav extends StatelessWidget {
  final List<Widget> options;

  CustomNav({@required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: options
            .map(
              (e) => Padding(
                child: e,
                padding: EdgeInsets.symmetric(
                  // horizontal: 10,
                  vertical: 20,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;
  final Color color;
  final Function onTap;

  CustomNavItem(
      {@required this.icon,
      @required this.text,
      this.onTap,
      this.active = false,
      this.color = Colors.white})
      : assert(icon != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: active? 70: 50,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active ? Theme.of(context).accentColor : color,
            ),
            YWhiteSpace(5),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: active ? Theme.of(context).accentColor : color),
            ),
          ],
        ),
      ),
    );
  }
}
