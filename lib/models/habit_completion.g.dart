// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitCompletion _$HabitCompletionFromJson(Map<String, dynamic> json) =>
    HabitCompletion(
      id: (json['id'] as num).toInt(),
      habitId: (json['habitId'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$HabitCompletionToJson(HabitCompletion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'date': instance.date.toIso8601String(),
    };
