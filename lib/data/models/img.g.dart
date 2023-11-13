// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'img.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsplashResult _$UnsplashResultFromJson(Map<String, dynamic> json) =>
    UnsplashResult(
      json['total'] as int,
      json['total_pages'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => CountryImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnsplashResultToJson(UnsplashResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };

CountryImage _$CountryImageFromJson(Map<String, dynamic> json) => CountryImage(
      json['id'] as String,
      Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryImageToJson(CountryImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      json['raw'] as String,
      json['full'] as String,
      json['regular'] as String,
      json['small'] as String,
      json['thumb'] as String,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };
