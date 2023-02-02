const String path = "assets/images/netflix/";

const String jw_hero = path + "john_wick_hero.jpg";
const String jw_title = path + "john_wick_title.png";
const String jw_poster = path + "john_wick_poster.jpg";
const String jw_trailer = path + "john_wick_trailer.jpg";
const String jw_desc =
    "An ex-hit-man comes out of retirement to track down the gangsters that killed his dog and took his car.";
const String jw_cast = "Keanu Reeves, Michael Nyqvist, Alfie Allen";
const String jw_detail = "2014 | R | 1h 41m";
const String jw_rating = "7.4";
const List jw_category = ["Action", "Crime", "Thriller"];

const String ba_trailer = path + "ba_trailer.jpg";
const String ba_poster = path + "ba_poster.jpg";
const String ba_desc =
    "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods--and imprisoned just as quickly--Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.";
const String ba_cast = "Dwayne Johnson, Aldis Hodge, Pierce Brosnan";
const String ba_detail = "2022 | PG-13 | 2h 5m";
const String ba_rating = "6.4";
const List ba_category = ["Action", "Fantasy", "Adventure"];

const String bt_poster = path + "bt_poster.jpeg";
const String bt_trailer = path + "bt_trailer.jpg";
const String bt_desc =
    "Five assassins aboard a swiftly-moving bullet train find out that their missions have something in common.";
const String bt_cast = "Brad Pitt, Joey King, Aaron Taylor-Johnson";
const String bt_detail = "2022 | R | 2h 7m";
const String bt_rating = "7.3";
const List bt_category = ["Action", "Comedy", "Thriller"];

const String ksi_poster = path + "ksi_poster.jpg";
const String ksi_trailer = path + "ksi_trailer.jpg";
const String ksi_desc =
    "After the Vietnam war, a team of scientists explores an uncharted island in the Pacific, venturing into the domain of the mighty Kong, and must fight to escape a primal Eden.";
const String ksi_cast = "Tom Hiddleston, Samuel L. Jackson, Brie Larson";
const String ksi_detail = "2017 | PG-13 | 1h 58m";
const String ksi_rating = "6.6";
const List ksi_category = ["Action", "Fantasy", "Adventure"];

const String ny_poster = path + "ny_poster.webp";
const String ny_trailer = path + "ny_trailer.jpeg";
const String ny_desc =
    "The Four Horsemen resurface, and are forcibly recruited by a tech genius to pull off their most impossible heist yet.";
const String ny_cast = "Jesse Eisenberg, Mark Ruffalo, Woody Harrelson";
const String ny_detail = "2016 | PG-13 | 2h 9m";
const String ny_rating = "6.4";
const List ny_category = ["Action", "Comedy", "Advendute"];

const String tl_poster = path + "tl_poster.jpg";
const String tl_trailer = path + "tl_trailer.jpg";
const String tl_desc =
    "A story of two brothers set during the Sino-Indian war, 1962: the younger one who's at war at the borders and the elder who's at war with his own world.";
const String tl_cast = "Salman Khan, Sohail Kha, Om Puri";
const String tl_detail = "2017 | Not Rated | 2h 16m";
const String tl_rating = "3.9";
const List tl_category = ["Drama", "War"];

const String st_title = path + "st_title.png";
const String st_poster = path + "st_poster.jpg";

const String pb_title = path + "pb_title.png";
const String pb_poster = path + "pb_poster.jpg";

class Movie {
  final String trailer;
  final String poster;
  final String desc;
  final String cast;
  final String detail;
  final String rating;
  final List category;

  const Movie(this.trailer, this.poster, this.desc, this.cast, this.detail,
      this.rating, this.category);
}

final List listMovie = [
  Movie(ba_trailer, ba_poster, ba_desc, ba_cast, ba_detail, ba_rating,
      ba_category),
  Movie(bt_trailer, bt_poster, bt_desc, bt_cast, bt_detail, bt_rating,
      bt_category),
  Movie(ksi_trailer, ksi_poster, ksi_desc, ksi_cast, ksi_detail, ksi_rating,
      ksi_category),
  Movie(ny_trailer, ny_poster, ny_desc, ny_cast, ny_detail, ny_rating,
      ny_category),
  Movie(tl_trailer, tl_poster, tl_desc, tl_cast, tl_detail, tl_rating,
      tl_category),
];
