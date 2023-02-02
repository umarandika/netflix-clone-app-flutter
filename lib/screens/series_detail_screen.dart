import 'dart:ui';

import "package:flutter/material.dart";
import 'package:umar12/api/api_utils.dart';
import 'package:umar12/screens/netflix_home.dart';
import 'package:umar12/styles/buttons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  String trailer;
  String poster;
  String desc;
  String cast;
  String detail;
  String rating;
  List category;

  DetailScreen(
      {Key? key,
      required this.trailer,
      required this.poster,
      required this.desc,
      required this.cast,
      required this.detail,
      required this.rating,
      required this.category});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late YoutubePlayerController _controller;
  // final videoUrl = "https://www.youtube.com/watch?v=pDJbckSMN0w";

  // @override
  // void initState() {
  //   _controller = YoutubePlayerController(
  //       initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
  //       flags: const YoutubePlayerFlags(
  //         mute: false,
  //         loop: false,
  //         autoPlay: false,
  //       ));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 512),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        // alignment: Alignment(0.0, -1),
                        fit: BoxFit.cover,
                        image: Image.asset(
                          widget.poster,
                          scale: 0.1,
                        ).image)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.5, sigmaY: 20.5),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                            icon: Icon(
                              Icons.close,
                            ),
                          ),
                        ),

                        Align(
                          child: Container(
                              // alignment: Alignment.centasder,
                              width: 130,
                              height: 180,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                        spreadRadius: 4,
                                        offset: Offset(0, 0))
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          Image.asset(widget.poster).image))),
                        ),

                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.rating + " (IMDB)",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 43, 147, 47),
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(padding: EdgeInsets.all(7)),
                                Text(
                                  widget.detail,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(horizontal: 12)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 224, 3, 3))),
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: EasyText(text: widget.desc, fontSize: 15),
                        ),
                        EasyText(
                            text: "Cast: " + widget.cast,
                            color: Colors.grey,
                            fontSize: 13),

                        Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.category.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      // color: Colors.blue,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: EasyText(
                                      text: widget.category[index],
                                      fontSize: 13),
                                );
                              }),
                        ),

                        //Details Button
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 15),
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    size: 30,
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  EasyText(
                                      text: "My List",
                                      color: Colors.grey,
                                      fontSize: 12),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    size: 30,
                                    Icons.thumb_up_off_alt,
                                    color: Colors.white,
                                  ),
                                  EasyText(
                                      text: "Rate",
                                      color: Colors.grey,
                                      fontSize: 12),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    size: 30,
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  EasyText(
                                      text: "Share",
                                      color: Colors.grey,
                                      fontSize: 12),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                width: 150,
                height: 5,
                color: Color.fromARGB(255, 224, 3, 3),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              // alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: EasyText(
                      text: "TRAILER",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            // alignment: Alignment(0.0, -1),
                            fit: BoxFit.cover,
                            image: Image.asset(
                              widget.trailer,
                              scale: 0.1,
                            ).image)),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // YoutubePlayer(
            //   controller: _controller,
            //   // bottomActions: [Fu],
            // ),
          ]),
        ));
  }
}
