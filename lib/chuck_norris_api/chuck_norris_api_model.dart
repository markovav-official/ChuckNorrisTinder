import 'package:json_annotation/json_annotation.dart';

part 'chuck_norris_api_model.g.dart';

@JsonSerializable()
class ChuckNorrisAPIModel {
  final String id;
  final String value;
  final String url;

  ChuckNorrisAPIModel(this.id, this.value, this.url);

  factory ChuckNorrisAPIModel.fromJson(Map<String, dynamic> json) =>
      _$ChuckNorrisAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChuckNorrisAPIModelToJson(this);
}
