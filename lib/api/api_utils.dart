import 'package:dio/dio.dart';

class ENDPOINT {
  static final _API_KEY = "0d6c4e305707e878b2812ea327d8b6d4";

  final _UPCOMING = "upcoming";
  final _POPULAR = "popular";
  // final _POPULAR = "now_playing";

  static final GET_NOWPLAYING =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$_API_KEY&language=en-US&page=1";
  static final GET_MOVIE = "https://api.themoviedb.org/3/movie/";

  // final _BASE_URL =
}

class APIFUNC {
  static Dio _dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      contentType: 'application/json',
    ),
  );

  static Future getUpcoming() async {
    try {
      final result = await _dio.get(ENDPOINT.GET_NOWPLAYING);
      final data = result.data;
      return data;
    } on DioError catch (e) {
      // print('[ERROR] on NmAPIUtils.PROVINCE: ${e.message}');
      print('body: ${e.response.toString()}');
      return "error";
    }
  }

  static Future getImages(int id) async {
    final GET_IMAGES =
        "${ENDPOINT.GET_MOVIE}$id/images?api_key=${ENDPOINT._API_KEY}";
    try {
      final result = await _dio.get(GET_IMAGES);
      final data = result.data;
      return data;
    } on DioError catch (e) {
      // print('[ERROR] on NmAPIUtils.PROVINCE: ${e.message}');
      print('body: ${e.response.toString()}');
      return "error";
    }
  }

  static Future getDetails(int id) async {
    final GET_DETAILS = "${ENDPOINT.GET_MOVIE}$id?api_key=${ENDPOINT._API_KEY}";
    try {
      final result = await _dio.get(GET_DETAILS);
      final data = result.data;
      return data;
    } on DioError catch (e) {
      // print('[ERROR] on NmAPIUtils.PROVINCE: ${e.message}');
      print('body: ${e.response.toString()}');
      return "error";
    }
  }
}
