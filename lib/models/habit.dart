import 'package:json_annotation/json_annotation.dart';
part 'habit.g.dart';

@JsonSerializable()
class Habit {
  Habit({required this.id, required this.name});

  final int id;
  final String name;
  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
}
