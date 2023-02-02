import 'package:dio/dio.dart';

class ENDPOINT {
  static final _API_KEY = "0d6c4e305707e878b2812ea327d8b6d4";

  final _UPCOMING = "upcoming";
  final _POPULAR = "popular";

  static final URL =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$_API_KEY&language=en-US&page=1";
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
      final result = await _dio.get(ENDPOINT.URL);
      final data = result.data;
      return data;
    } on DioError catch (e) {
      // print('[ERROR] on NmAPIUtils.PROVINCE: ${e.message}');
      print('body: ${e.response.toString()}');
      return "error";
    }
  }
}
