import 'package:json_annotation/json_annotation.dart';

part 'img.g.dart';

@JsonSerializable()
class UnsplashResult {
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<CountryImage> results;

  UnsplashResult(this.total, this.totalPages, this.results);

  factory UnsplashResult.fromJson(Map<String, dynamic> json) =>
      _$UnsplashResultFromJson(json);

  Map<String, dynamic> toJson() => _$UnsplashResultToJson(this);
}

@JsonSerializable()
class CountryImage {
  final String id;
  final Urls urls;

  CountryImage(this.id, this.urls);

  factory CountryImage.fromJson(Map<String, dynamic> json) =>
      _$CountryImageFromJson(json);

  Map<String, dynamic> toJson() => _$CountryImageToJson(this);
}

@JsonSerializable()
class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Urls(this.raw, this.full, this.regular, this.small, this.thumb);

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
