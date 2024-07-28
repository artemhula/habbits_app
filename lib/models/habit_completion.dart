import 'package:json_annotation/json_annotation.dart';
 
part 'habit_completion.g.dart';

@JsonSerializable()
class HabitCompletion {
  final int id;
  final int habitId;
  final DateTime date;

  HabitCompletion(
      {required this.id, required this.habitId, required this.date});

  factory HabitCompletion.fromJson(Map<String, dynamic> json) =>
      _$HabitCompletionFromJson(json);

  Map<String, dynamic> toJson() => _$HabitCompletionToJson(this);
}
