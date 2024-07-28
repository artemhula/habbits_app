import 'package:json_annotation/json_annotation.dart';
 
part 'habit_complection.g.dart';
@JsonSerializable()
class HabitComplection {
  final int id;
  final int habitId;
  final DateTime date;

  HabitComplection(
      {required this.id, required this.habitId, required this.date});

  factory HabitComplection.fromJson(Map<String, dynamic> json) =>
      _$HabitComplectionFromJson(json);

  Map<String, dynamic> toJson() => _$HabitComplectionToJson(this);
}
