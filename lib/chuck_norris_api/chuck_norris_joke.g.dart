// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chuck_norris_joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChuckNorrisJoke _$ChuckNorrisJokeFromJson(Map<String, dynamic> json) =>
    ChuckNorrisJoke(
      json['id'] as String,
      json['value'] as String,
      json['url'] as String,
    )..color = json['color'] as int?;

Map<String, dynamic> _$ChuckNorrisJokeToJson(ChuckNorrisJoke instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'url': instance.url,
      'color': instance.color,
    };
