// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      reminderEnable: json['reminderEnable'] as bool,
      reminderHours: (json['reminderHours'] as num?)?.toInt(),
      reminderMinutes: (json['reminderMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reminderEnable': instance.reminderEnable,
      'reminderHours': instance.reminderHours,
      'reminderMinutes': instance.reminderMinutes,
    };
