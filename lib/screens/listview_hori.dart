// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ListViewHori extends StatelessWidget {
  static String path = "assets/images/";
  final List<dynamic> listRaiden = [
    "${path}1.png",
    "${path}2.png",
    "${path}3.jpg",
    "${path}4.jpg",
    "${path}5.png",
  ];

  @override
  Widget build(BuildContext context) {
    // print(listRaiden);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Wives",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 200,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage(listRaiden[index]),
                            fit: BoxFit.cover)),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
