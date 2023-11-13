import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class WeatherForecast {
  final Coord coord;
  final List<Weather> weather;
  final Main main;
  final Wind wind;

  WeatherForecast(this.coord, this.weather, this.main, this.wind);

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}

@JsonSerializable()
class WeatherForecast2 {
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  @JsonKey(name: 'dt_txt')
  final DateTime dtTxt;

  WeatherForecast2(this.weather, this.main, this.wind, this.dtTxt);

  factory WeatherForecast2.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecast2FromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecast2ToJson(this);
}

@JsonSerializable()
class WeatherForecastMultiple {
  final List<WeatherForecast2> list;

  WeatherForecastMultiple(this.list);

  factory WeatherForecastMultiple.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastMultipleFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastMultipleToJson(this);
}

@JsonSerializable()
class Coord {
  final double lat;
  final double lon;
  Coord(this.lat, this.lon);

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(this.id, this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Main {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;
  final int humidity;

  Main(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.humidity);

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind {
  final double speed;
  final int deg;

  Wind(this.speed, this.deg);
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}
