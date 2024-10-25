import 'package:json_annotation/json_annotation.dart';
part 'habit.g.dart';

@JsonSerializable()
class Habit {
  Habit({
    required this.id,
    required this.name,
    required this.reminderEnable,
    this.reminderHours,
    this.reminderMinutes,
  });

  final int id;
  final String name;
  final bool reminderEnable;
  final int? reminderHours;
  final int? reminderMinutes;
  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
}
