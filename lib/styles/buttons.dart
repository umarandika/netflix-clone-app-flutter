import 'dart:ui';

import 'package:flutter/material.dart';

final ButtonStyle primaryStyle = ElevatedButton.styleFrom(
  onSurface: const Color.fromARGB(255, 224, 3, 3),
  surfaceTintColor: const Color.fromARGB(255, 224, 3, 3),
  onPrimary: const Color.fromARGB(255, 224, 3, 3),
  primary: Colors.white,
  textStyle: TextStyle(fontWeight: FontWeight.bold),
  // minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 15),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
