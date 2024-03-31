// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ENDPOINT {
  static const _API_KEY = "0d6c4e305707e878b2812ea327d8b6d4";
  static const _API_PARAM = "?api_key=$_API_KEY";

  static const GET_MOVIE = "https://api.themoviedb.org/3/movie/";
  static const GET_SERIES = "https://api.themoviedb.org/3/tv/";
  static const GET_NOWPLAYING =
      "${GET_MOVIE}now_playing$_API_PARAM&language=en-US&page=1";
  static const GET_POPULAR =
      "https://api.themoviedb.org/3/trending/movie/week$_API_PARAM&language=en-US&page=1";

  static const GET_TOPRATED_SERIES = "${GET_SERIES}top_rated$_API_PARAM";

  // final _BASE_URL =
}

class APIFUNC {
  static Dio _dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      contentType: 'application/json',
    ),
  );

  static Future getTopRatedSeries() async {
    try {
      final result = await _dio.get(ENDPOINT.GET_TOPRATED_SERIES);
      final data = result.data;
      return data;
    } on DioError catch (e) {
      // print('[ERROR] on NmAPIUtils.PROVINCE: ${e.message}');
      print('body: ${e.response.toString()}');
      return "error";
    }
  }

  static Future getDetailsSeries(int id) async {
    final GET_DETAILS =
        "${ENDPOINT.GET_SERIES}$id${ENDPOINT._API_PARAM}&append_to_response=images,credits";
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

  static Future getNowPlaying() async {
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

  static Future getPopular() async {
    try {
      final result = await _dio.get(ENDPOINT.GET_POPULAR);
      final data = result.data;
      return data;
    } on DioError catch (e) {
      // print('[ERROR] on NmAPIUtils.PROVINCE: ${e.message}');
      print('body: ${e.response.toString()}');
      return "error";
    }
  }

  static Future getDetails(int id) async {
    final GET_DETAILS =
        "${ENDPOINT.GET_MOVIE}$id?api_key=${ENDPOINT._API_KEY}&append_to_response=images,credits";
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
