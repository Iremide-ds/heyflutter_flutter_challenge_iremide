// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUnit _$CurrentUnitFromJson(Map<String, dynamic> json) => CurrentUnit(
      DateTime.parse(json['time'] as String),
      (json['temperature_2m'] as num).toDouble(),
      (json['relative_humidity_2m'] as num).toDouble(),
      (json['apparent_temperature'] as num).toDouble(),
      (json['wind_speed_10m'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentUnitToJson(CurrentUnit instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature_2m': instance.temperature,
      'relative_humidity_2m': instance.relativeHumidity,
      'apparent_temperature': instance.apparentTemperature,
      'wind_speed_10m': instance.windSpeed,
    };
