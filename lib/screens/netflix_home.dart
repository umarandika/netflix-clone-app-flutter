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
  static String path = "assets/images/";
  static String netflix_path = "assets/images/netflix/";

  Map upcoming = {};

  @override
  void initState() {
    getUpcoming();
  }

  Future<void> getUpcoming() async {
    // get API user from endpoint USER
    final get = await APIFUNC.getUpcoming();

    setState(() {
      upcoming = get;
    });
    print(upcoming["results"]);
  }

  @override
  Widget build(BuildContext context) {
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
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: FractionalOffset.topCenter,
                              image: Image.asset(path + "5.png").image,
                              fit: BoxFit.fitWidth)),
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
                height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment(0.0, -1),
                        fit: BoxFit.cover,
                        image: Image.asset(jw_hero).image))),
            Container(
                alignment: Alignment.topCenter,
                height: 500,
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
                Image.asset(jw_title),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EasyText(
                        text: "Action",
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    Dot(),
                    EasyText(
                        text: "Crime",
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    Dot(),
                    EasyText(
                        text: "Thriller",
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ],
                ),
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
                              trailer: jw_trailer,
                              poster: jw_poster,
                              desc: jw_desc,
                              rating: jw_rating,
                              detail: jw_detail,
                              cast: jw_cast,
                              category: jw_category,
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
                        "You Might Like",
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
                          itemCount: listMovie.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DetailScreen(
                                      trailer: listMovie[index].trailer,
                                      poster: listMovie[index].poster,
                                      desc: listMovie[index].desc,
                                      rating: listMovie[index].rating,
                                      detail: listMovie[index].detail,
                                      cast: listMovie[index].cast,
                                      category: listMovie[index].category,
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
                                        image:
                                            Image.asset(listMovie[index].poster)
                                                .image,
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
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          // color: Colors.white
                          image: DecorationImage(
                              image: Image.asset(st_poster).image,
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          color: Color.fromARGB(117, 8, 8, 8),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EasyText(
                                text: "A NETFLIX ORIGINAL",
                                fontSize: 10,
                                padding: EdgeInsets.only(bottom: 5),
                              ),
                              Image.asset(
                                st_title,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            EasyText(
                                                text: "Action",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                            Dot(),
                                            EasyText(
                                                text: "Crime",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                            Dot(),
                                            EasyText(
                                                text: "Thriller",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ],
                                        ),
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
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          // color: Colors.white
                          image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: Image.asset(pb_poster).image,
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          color: Color.fromARGB(117, 8, 8, 8),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EasyText(
                                text: "A NETFLIX ORIGINAL",
                                fontSize: 10,
                                padding: EdgeInsets.only(bottom: 5),
                              ),
                              Image.asset(
                                pb_title,
                                width: 170,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            EasyText(
                                                text: "Action",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                            Dot(),
                                            EasyText(
                                                text: "Crime",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                            Dot(),
                                            EasyText(
                                                text: "Thriller",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ],
                                        ),
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
                    )
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
