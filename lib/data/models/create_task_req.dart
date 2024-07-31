import 'package:json_annotation/json_annotation.dart';

part 'create_task_req.g.dart';

@JsonSerializable()
class CreateTaskReq {
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "section_id")
  final String? sectionId;
  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "description")
  final String? description;

  CreateTaskReq({
    this.content,
    this.sectionId,
    this.createdAt,
    this.description,
  });

  CreateTaskReq copyWith({
    String? content,
    String? sectionId,
    String? createdAt,
    String? description,
  }) =>
      CreateTaskReq(
        content: content ?? this.content,
        sectionId: sectionId ?? this.sectionId,
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
      );

  factory CreateTaskReq.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaskReqToJson(this);
}
