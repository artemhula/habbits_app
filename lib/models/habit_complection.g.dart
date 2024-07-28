// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_complection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitComplection _$HabitComplectionFromJson(Map<String, dynamic> json) =>
    HabitComplection(
      id: (json['id'] as num).toInt(),
      habitId: (json['habitId'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$HabitComplectionToJson(HabitComplection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'date': instance.date.toIso8601String(),
    };
