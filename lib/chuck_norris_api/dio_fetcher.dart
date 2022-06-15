import 'package:chuck_norris_tinder/chuck_norris_api/chuck_norris_joke.dart';
import 'package:dio/dio.dart';

class DioFetcher {
  static const String baseURL = "https://api.chucknorris.io";
  static const String categories = "/jokes/categories";
  static const String randomJokes = "/jokes/random";

  static final Dio _dio = Dio(
    BaseOptions(
      method: "GET",
    ),
  );

  static Future<ChuckNorrisJoke> getRandomJoke(String category) async {
    String url = baseURL + randomJokes;
    if (category != "All jokes") url += "?category=$category";
    var response = await _dio.get<Map<String, dynamic>>(url);
    return ChuckNorrisJoke.fromJson(response.data!);
  }

  static Future<List<String>> getCategories() async {
    var response = await _dio.get<List>(baseURL + categories);
    return response.data!.map((e) => e as String).toList();
  }
}
