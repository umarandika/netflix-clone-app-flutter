import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:umar12/screens/nav_bar_netflix.dart';
import 'package:umar12/screens/netflix_home.dart';
import 'screens/listview_vert.dart';

import 'screens/listview_hori.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, home: NavBar(),
      theme: ThemeData(fontFamily: 'NetflixSans'),

      // Scaffold(iii
      //     backgroundColor: Colors.black,
      //     appBar: AppBar(title: Text("Bencana terberat ilmu adalah lupa")),
      //     body: NetflixHome())
    );
  }
}
