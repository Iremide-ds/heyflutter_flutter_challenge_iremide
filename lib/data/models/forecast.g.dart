// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) =>
    WeatherForecast(
      Coord.fromJson(json['coord'] as Map<String, dynamic>),
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      Main.fromJson(json['main'] as Map<String, dynamic>),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
    };

WeatherForecast2 _$WeatherForecast2FromJson(Map<String, dynamic> json) =>
    WeatherForecast2(
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      Main.fromJson(json['main'] as Map<String, dynamic>),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
      DateTime.parse(json['dt_txt'] as String),
    );

Map<String, dynamic> _$WeatherForecast2ToJson(WeatherForecast2 instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
      'dt_txt': instance.dtTxt.toIso8601String(),
    };

WeatherForecastMultiple _$WeatherForecastMultipleFromJson(
        Map<String, dynamic> json) =>
    WeatherForecastMultiple(
      (json['list'] as List<dynamic>)
          .map((e) => WeatherForecast2.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherForecastMultipleToJson(
        WeatherForecastMultiple instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      (json['lat'] as num).toDouble(),
      (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['id'] as int,
      json['main'] as String,
      json['description'] as String,
      json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      (json['temp'] as num).toDouble(),
      (json['feels_like'] as num).toDouble(),
      (json['temp_min'] as num).toDouble(),
      (json['temp_max'] as num).toDouble(),
      json['pressure'] as int,
      json['humidity'] as int,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      (json['speed'] as num).toDouble(),
      json['deg'] as int,
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };
