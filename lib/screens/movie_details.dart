import 'dart:ui';

import "package:flutter/material.dart";
import 'package:umar12/api/api_utils.dart';
import 'package:umar12/screens/netflix_home.dart';
import 'package:umar12/styles/buttons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;

  DetailScreen({Key? key, required this.movieId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late YoutubePlayerController _controller;
  Map upcoming = {};
  Map genres = {};
  Map movieDetails = {};
  List logos = [];
  List posters = [];
  final String imagePath = 'https://image.tmdb.org/t/p/original';
  // final videoUrl = "https://www.youtube.com/watch?v=pDJbckSMN0w";

  @override
  void initState() {
    // _controller = YoutubePlayerController(
    //     initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
    //     flags: const YoutubePlayerFlags(
    //       mute: false,
    //       loop: false,
    //       autoPlay: false,
    //     ));
    getDetails(widget.movieId);
    super.initState();
  }

  Future<void> getDetails(int id) async {
    // get API user from endpoint USER
    final getDetails = await APIFUNC.getDetails(id);
    print("GET DETAILSSSSS");
    setState(() {
      movieDetails = getDetails;
    });
    print("GET DETAILSSSSS" + " " + movieDetails.toString());
    print("LOGOS " + movieDetails["images"]["logos"].toString());
    print("MOVIE DETAILS $movieDetails");

    setState(() {
      logos = movieDetails["images"]["logos"];
      posters = movieDetails["images"]["posters"];
      print("D O N E");
    });
  }

  String cast() {
    Map credits = movieDetails["credits"];
    String names = "";
    List<String> cast = [];
    for (int i = 0; i < 3; i++) {
      cast.add(credits["cast"][i]["name"]);
    }
    for (String name in cast) {
      if (name == cast[cast.length - 1])
        names += name;
      else
        names += name + ", ";
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    print("GENRES" + movieDetails["genres"].toString());
    // print("CAST" + cast().join(", ").toString());
    List<String> genreNames = [];
    int genreLength = movieDetails["genres"].length;
    for (int i = 0; i < genreLength; i++) {
      genreNames.add(movieDetails["genres"][i]["name"]);
    }
    print("GENRE NAMES" + genreNames.toString());
    String date = movieDetails["release_date"];
    List<String> dateParts = date.split('-');
    String year = dateParts[0];
    int minutes = movieDetails["runtime"];
    int hours = minutes ~/ 60; // Integer division
    int remainingMinutes = minutes % 60; // Modulus to get remaining minutes

    String runtime = "${hours}hr ${remainingMinutes}min";
    print(year);
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
                        image: NetworkImage(
                          imagePath + movieDetails["poster_path"],
                          scale: 0.1,
                        ))),
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
                              // alignment: Alignment.center,
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
                                      image: NetworkImage(imagePath +
                                          movieDetails["poster_path"])))),
                        ),

                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  movieDetails["vote_average"].toString() +
                                      " (${movieDetails["vote_count"]})",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 43, 147, 47),
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(padding: EdgeInsets.all(7)),
                                Text(
                                  year + " | " + runtime,
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
                        EasyText(
                          text: movieDetails["title"],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: EasyText(
                              text: movieDetails["overview"], fontSize: 15),
                        ),
                        EasyText(
                            text: "Cast: ${cast()}",
                            color: Colors.grey,
                            fontSize: 13),

                        Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: genreNames.length,
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
                                      text: genreNames[index], fontSize: 13),
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
                            image: NetworkImage(
                              imagePath + movieDetails["backdrop_path"],
                              scale: 0.1,
                            ))),
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
