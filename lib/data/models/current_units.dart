import 'package:json_annotation/json_annotation.dart';

part 'current_units.g.dart';

@JsonSerializable()
class CurrentUnit {
  final DateTime time;

  @JsonKey(name: 'temperature_2m')
  final double temperature;

  @JsonKey(name: 'relative_humidity_2m')
  final double relativeHumidity;

  @JsonKey(name: 'apparent_temperature')
  final double apparentTemperature;

  @JsonKey(name: 'wind_speed_10m')
  final double windSpeed;

  CurrentUnit(this.time, this.temperature, this.relativeHumidity,
      this.apparentTemperature, this.windSpeed);

  factory CurrentUnit.fromJson(Map<String, dynamic> json) =>
      _$CurrentUnitFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUnitToJson(this);
}
