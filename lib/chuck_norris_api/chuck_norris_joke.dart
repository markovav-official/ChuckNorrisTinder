import 'package:json_annotation/json_annotation.dart';

part 'chuck_norris_joke.g.dart';

@JsonSerializable()
class ChuckNorrisJoke {
  final String id;
  final String value;
  final String url;
  int? color;

  ChuckNorrisJoke(this.id, this.value, this.url);

  factory ChuckNorrisJoke.fromJson(Map<String, dynamic> json) =>
      _$ChuckNorrisJokeFromJson(json);

  Map<String, dynamic> toJson() => _$ChuckNorrisJokeToJson(this);
}
