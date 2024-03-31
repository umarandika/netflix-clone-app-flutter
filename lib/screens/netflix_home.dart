// ignore_for_file: sort_child_properties_last, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:umar12/models/images.dart';
import 'package:umar12/screens/movie_details.dart';

import '../api/api_utils.dart';

class NetflixHome extends StatefulWidget {
  NetflixHome({Key? key}) : super(key: key);

  @override
  State<NetflixHome> createState() => _NetflixHomeState();
}

class _NetflixHomeState extends State<NetflixHome> {
  // static String path = "assets/images/";
  static String netflix_path = "assets/images/netflix/";
  static int movieID = 0;

  Map nowPlaying = {};
  Map topRatedSeries = {};
  Map seriesDetails = {};
  Map popular = {};
  Map genres = {};
  Map movieDetails = {};
  List logos = [];
  List posters = [];
  List<Map> seriesList = [];

  @override
  void initState() {
    super.initState();
    getNowPlaying();
    getPopular();
    getTopRatedSeries();
  }

  // GET DETAILS SERIES
  Future<Map> getDetailsSeries(int id) async {
    final get = await APIFUNC.getDetailsSeries(id);
    setState(() {
      seriesDetails = get;
    });
    print("DETAIL SERIES" + seriesDetails.toString());
    return seriesDetails;
  }

  // GET TOP RATED SERIES
  Future<void> getTopRatedSeries() async {
    final get = await APIFUNC.getTopRatedSeries();
    setState(() {
      topRatedSeries = get;
    });
    List<Map> filteredSeries = [];
    for (var series in topRatedSeries["results"]) {
      if (series["vote_average"] > 8 &&
          series["vote_count"] > 3000 &&
          filteredSeries.length < 3) {
        filteredSeries.add(series);
      }
    }
    setState(() {
      topRatedSeries["results"] = filteredSeries;
    });
    for (int i = 0; i < topRatedSeries["results"].length; i++) {
      final temp = await getDetailsSeries(topRatedSeries["results"][i]["id"]);
      Map tempMap = {
        "id": topRatedSeries["results"][i]["id"],
        "name": topRatedSeries["results"][i]["name"],
        "poster_path": topRatedSeries["results"][i]["poster_path"],
        "backdrop_path": topRatedSeries["results"][i]["backdrop_path"],
        "genres": temp["genres"],
        "overview": temp["overview"],
        "vote_average": temp["vote_average"],
        "vote_count": temp["vote_count"],
        "images": temp["images"],
        "credits": temp["credits"]
      };
      setState(() {
        seriesList.add(tempMap);
      });
    }
  }

  // GET NOW PLAYING MOVIES
  Future<void> getNowPlaying() async {
    final get = await APIFUNC.getNowPlaying();

    setState(() {
      nowPlaying = get;
    });
    print(nowPlaying["results"]);
    print('https://image.tmdb.org/t/p/w154' +
        nowPlaying["results"][2]["poster_path"]);
    setState(() {
      movieID = nowPlaying["results"][0]["id"];
    });
    await getDetails(movieID);
  }

  // GET POPULAR MOVIES
  Future<void> getPopular() async {
    final get = await APIFUNC.getPopular();

    setState(() {
      popular = get;
    });
  }

  // GET DETAILS MOVIES
  Future<void> getDetails(int id) async {
    final getDetails = await APIFUNC.getDetails(id);
    setState(() {
      movieDetails = getDetails;
    });
    setState(() {
      logos = movieDetails["images"]["logos"];
      posters = movieDetails["images"]["posters"];
    });
  }

  Map searchLogo(logos) {
    for (var logo in logos) {
      if (logo["iso_639_1"] == "en") {
        return logo;
      }
    }
    return {};
  }

  Map searchHeroPoster(posters) {
    for (var poster in posters) {
      if (poster["iso_639_1"] == null) {
        return poster;
      }
    }
    return {};
  }

  final String imagePath = 'https://image.tmdb.org/t/p/original';

  @override
  Widget build(BuildContext context) {
    final String heroLogo = searchLogo(logos)["file_path"];
    print("POSTERS ${searchHeroPoster(posters)["file_path"]}");
    final String heroPoster = searchHeroPoster(posters)["file_path"];
    print(heroLogo);
    print("HERO POSTER" + heroPoster);
    print("GENRES" + movieDetails["genres"].toString());
    List<String> genreNames = [];
    int genreLength =
        movieDetails["genres"].length > 3 ? 3 : movieDetails["genres"].length;
    for (int i = 0; i < genreLength; i++) {
      genreNames.add(movieDetails["genres"][i]["name"]);
    }
    print("GENRE NAMES" + genreNames.toString());
    List<Widget> widgetGenre = [];
    for (int i = 0; i < genreNames.length; i++) {
      widgetGenre.add(
        EasyText(
            text: genreNames[i], fontWeight: FontWeight.bold, fontSize: 12),
      );
      if (i != genreNames.length - 1) {
        widgetGenre.add(
          Dot(),
        );
      }
    }
    print("BACKDROP PATH" + imagePath + movieDetails["backdrop_path"]);

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    netflix_path + "netflix_logo1.png",
                    height: 27,
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 1.50,
                  //   padding: EdgeInsets.symmetric(horizontal: 17, vertical: 9),
                  //   child: EasyText(text: "Search", fontSize: 13),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.4),
                  //       borderRadius: BorderRadius.all(Radius.circular(4))),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.white,
                    ),
                  )
                ]),
            color: Colors.transparent,
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Stack(alignment: Alignment.center, children: [
            Container(
                alignment: Alignment.topCenter,
                height: 600,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment(0.0, -1),
                        fit: BoxFit.cover,
                        image: NetworkImage(imagePath + heroPoster)))),
            Container(
                alignment: Alignment.topCenter,
                height: 600,
                decoration: const BoxDecoration(
                    // color: Colors.black,
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent]))),
            Positioned(
              width: 250,
              bottom: 0,
              child: Column(children: [
                Image.network(imagePath + heroLogo, height: 100),
                Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widgetGenre),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeroButton(
                      text: "Watch",
                      icon: Icons.play_arrow,
                      playbtn: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DetailScreen(
                              movieId: movieID,
                            );
                          }),
                        );
                      },
                    ),
                    HeroButton(
                      text: "My List",
                      icon: Icons.add,
                      playbtn: false,
                      onPressed: () => print("asd"),
                    ),
                  ],
                )
              ]),
            )
          ])),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Now Playing",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DetailScreen(
                                      movieId: nowPlaying["results"][index + 1]
                                          ["id"],
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // height: 150,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(3)),
                                    image: DecorationImage(
                                        image: NetworkImage(imagePath +
                                            nowPlaying["results"][index + 1]
                                                ["poster_path"]),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Popular",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DetailScreen(
                                      movieId: popular["results"][index + 1]
                                          ["id"],
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // height: 150,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(3)),
                                    image: DecorationImage(
                                        image: NetworkImage(imagePath +
                                            popular["results"][index + 1]
                                                ["poster_path"]),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                    ),
                  ]),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 6.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 24.0),
            //         child: Text(
            //           "yo",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //       Container(
            //         height: 220.0,
            //         child: ListView.builder(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 12.0,
            //             horizontal: 16.0,
            //           ),
            //           scrollDirection: Axis.horizontal,
            //           itemCount: 5,
            //           itemBuilder: (BuildContext context, int index) {
            //             final content = listMovie[index];
            //             return GestureDetector(
            //               // onTap: () => print(content.name),
            //               child: Container(
            //                 margin: const EdgeInsets.symmetric(horizontal: 8.0),
            //                 height: 200.0,
            //                 width: 130.0,
            //                 decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                     image: Image.asset(
            //                             "assets/images/netflix/black_adam.webp")
            //                         .image,
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 18, right: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Netflix Originals",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    for (int i = 0; i < seriesList.length; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailScreen(
                                movieId: seriesList[i]["id"],
                              );
                            }),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            // color: Colors.white
                            image: DecorationImage(
                                image: NetworkImage(
                                    imagePath + seriesList[i]["backdrop_path"]),
                                fit: BoxFit.cover),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(222, 8, 8, 8),
                                Color.fromARGB(59, 8, 8, 8),
                              ],
                              stops: [0.0, 0.7],
                            )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EasyText(
                                  text: "A NETFLIX ORIGINALS",
                                  fontSize: 10,
                                  padding: const EdgeInsets.only(bottom: 5),
                                ),
                                Image.network(
                                  imagePath +
                                      seriesList[i]["images"]["logos"][0]
                                          ["file_path"],
                                  width: 130,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: EasyText(
                                                text: "2016 | PG-13 | 2h 9m",
                                                fontSize: 13,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 120)),
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: widgetGenre,
                                          // ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.play_circle,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    // GestureDetector(
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 12),
                    //     height: 150,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(3)),
                    //       // color: Colors.white
                    //       image: DecorationImage(
                    //           image: Image.asset(st_poster).image,
                    //           fit: BoxFit.cover),
                    //     ),
                    //     child: Container(
                    //       color: Color.fromARGB(117, 8, 8, 8),
                    //       padding: EdgeInsets.all(10),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           EasyText(
                    //             text: "A NETFLIX ORIGINAL",
                    //             fontSize: 10,
                    //             padding: EdgeInsets.only(bottom: 5),
                    //           ),
                    //           Image.asset(
                    //             st_title,
                    //             width: 130,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 10.0),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.only(
                    //                           bottom: 8.0),
                    //                       child: EasyText(
                    //                           text: "2016 | PG-13 | 2h 9m",
                    //                           fontSize: 13,
                    //                           color: Color.fromRGBO(
                    //                               255, 255, 255, 120)),
                    //                     ),
                    //                     Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         EasyText(
                    //                             text: "Action",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                         Dot(),
                    //                         EasyText(
                    //                             text: "Crime",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                         Dot(),
                    //                         EasyText(
                    //                             text: "Thriller",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Icon(
                    //                   Icons.play_circle,
                    //                   color: Colors.white,
                    //                   size: 40,
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // // GestureDetector(
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 12),
                    //     height: 150,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(3)),
                    //       // color: Colors.white
                    //       image: DecorationImage(
                    //           alignment: Alignment.topCenter,
                    //           image: Image.asset(pb_poster).image,
                    //           fit: BoxFit.cover),
                    //     ),
                    //     child: Container(
                    //       color: Color.fromARGB(117, 8, 8, 8),
                    //       padding: EdgeInsets.all(10),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           EasyText(
                    //             text: "A NETFLIX ORIGINAL",
                    //             fontSize: 10,
                    //             padding: EdgeInsets.only(bottom: 5),
                    //           ),
                    //           Image.asset(
                    //             pb_title,
                    //             width: 170,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 10.0),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.only(
                    //                           bottom: 8.0),
                    //                       child: EasyText(
                    //                           text: "2016 | PG-13 | 2h 9m",
                    //                           fontSize: 13,
                    //                           color: Color.fromRGBO(
                    //                               255, 255, 255, 120)),
                    //                     ),
                    //                     Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         EasyText(
                    //                             text: "Action",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                         Dot(),
                    //                         EasyText(
                    //                             text: "Crime",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                         Dot(),
                    //                         EasyText(
                    //                             text: "Thriller",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Icon(
                    //                   Icons.play_circle,
                    //                   color: Colors.white,
                    //                   size: 40,
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ]),
            ),
          )
        ]

            //     BoxDecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage("assets/images/netflix/black_adam.webp"),
            // )

            ));
  }
}

class Dot extends StatelessWidget {
  const Dot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        "●",
        style: TextStyle(color: Color.fromARGB(255, 217, 142, 89)),
      ),
    );
  }
}

class EasyText extends StatelessWidget {
  final String text;
  FontWeight fontWeight;
  final double fontSize;
  Color color;
  EdgeInsetsGeometry padding;

  EasyText(
      {Key? key,
      this.padding = const EdgeInsets.all(0),
      required this.text,
      this.fontWeight = FontWeight.normal,
      required this.fontSize,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style:
            TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class HeroButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool playbtn;
  double btnWidth;
  Function() onPressed;

  HeroButton(
      {Key? key,
      this.btnWidth = 15.0,
      required this.text,
      required this.icon,
      required this.playbtn,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: playbtn
          ? ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: btnWidth)),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 224, 3, 3)))
          : ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 15)),
              side: MaterialStateProperty.all(BorderSide(color: Colors.white))),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Padding(
        padding: EdgeInsets.only(right: 7),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
