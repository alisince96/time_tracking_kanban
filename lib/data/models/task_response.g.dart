// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      creatorId: json['creator_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      assigneeId: json['assignee_id'],
      assignerId: json['assigner_id'],
      commentCount: (json['comment_count'] as num?)?.toInt(),
      isCompleted: json['is_completed'] as bool?,
      content: json['content'] as String?,
      description: json['description'] as String?,
      sectionId: json['section_id'] as String?,
      due: json['due'] == null
          ? null
          : Due.fromJson(json['due'] as Map<String, dynamic>),
      priority: (json['priority'] as num?)?.toInt(),
      id: json['id'] as String?,
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      timeSpent: json['time_spent'] == null
          ? null
          : Duration(microseconds: (json['time_spent'] as num).toInt()),
    );

Map<String, dynamic> _$TaskResponseToJson(TaskResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('creator_id', instance.creatorId);
  writeNotNull('section_id', instance.sectionId);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('assignee_id', instance.assigneeId);
  writeNotNull('assigner_id', instance.assignerId);
  writeNotNull('comment_count', instance.commentCount);
  writeNotNull('is_completed', instance.isCompleted);
  writeNotNull('content', instance.content);
  writeNotNull('priority', instance.priority);
  writeNotNull('description', instance.description);
  writeNotNull('due', instance.due);
  writeNotNull('start_time', instance.startTime?.toIso8601String());
  writeNotNull('end_time', instance.endTime?.toIso8601String());
  writeNotNull('time_spent', instance.timeSpent?.inMicroseconds);
  return val;
}

Due _$DueFromJson(Map<String, dynamic> json) => Due(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      isRecurring: json['is_recurring'] as bool?,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      string: json['string'] as String?,
      timezone: json['timezone'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DueToJson(Due instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'is_recurring': instance.isRecurring,
      'datetime': instance.datetime?.toIso8601String(),
      'string': instance.string,
      'timezone': instance.timezone,
      'id': instance.id,
    };
