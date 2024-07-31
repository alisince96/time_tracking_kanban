// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskReq _$CreateTaskReqFromJson(Map<String, dynamic> json) =>
    CreateTaskReq(
      content: json['content'] as String?,
      sectionId: json['section_id'] as String?,
      createdAt: json['created_at'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreateTaskReqToJson(CreateTaskReq instance) =>
    <String, dynamic>{
      'content': instance.content,
      'section_id': instance.sectionId,
      'created_at': instance.createdAt,
      'description': instance.description,
    };
