import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget iconWidget(icon, onTap, size, color) {
  return FloatingActionButton(
    mini: true,
    onPressed: onTap,
    child: Icon(
      icon,
      size: size,
      color: color,
    ),
  );
}


