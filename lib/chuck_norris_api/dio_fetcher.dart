import 'package:chuck_norris_tinder/chuck_norris_api/chuck_norris_api_model.dart';
import 'package:dio/dio.dart';

class DioFetcher {
  static final Dio _dio = Dio(
    BaseOptions(
      method: "GET",
      baseUrl: "https://api.chucknorris.io/jokes/random",
    ),
  );

  Future<ChuckNorrisAPIModel> getRandomJoke() async {
    var response = await _dio.get<Map<String, dynamic>>("");
    return ChuckNorrisAPIModel.fromJson(response.data!);
  }
}
