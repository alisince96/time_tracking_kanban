import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable(includeIfNull: false)
class Comment {
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "posted_at")
  final DateTime? postedAt;
  @JsonKey(name: "project_id")
  final dynamic projectId;
  @JsonKey(name: "task_id")
  final String? taskId;

  Comment({
    this.content,
    this.id,
    this.postedAt,
    this.projectId,
    this.taskId,
  });

  Comment copyWith({
    String? content,
    String? id,
    DateTime? postedAt,
    dynamic projectId,
    String? taskId,
  }) =>
      Comment(
        content: content ?? this.content,
        id: id ?? this.id,
        postedAt: postedAt ?? this.postedAt,
        projectId: projectId ?? this.projectId,
        taskId: taskId ?? this.taskId,
      );

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
