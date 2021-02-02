import 'package:flutter/material.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/splash.dart';

Widget genderWidget(icon, text, size, selected, onTap) {
  Color color1 = HexColor("#eb4b44");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: onTap,
        child: Icon(
          icon,
          size: 30,
          color: selected == text ? color1 : Colors.black54,
        ),
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
      Text(
        text,
        style: TextStyle(
          color: selected == text ? color1 : Colors.black,
        ),
      )
    ],
  );
}
