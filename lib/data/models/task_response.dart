import 'package:json_annotation/json_annotation.dart';
part 'task_response.g.dart';

@JsonSerializable(includeIfNull: false)
class TaskResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "creator_id")
  final String? creatorId;
  @JsonKey(name: "section_id")
  final String? sectionId;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "assignee_id")
  final dynamic assigneeId;
  @JsonKey(name: "assigner_id")
  final dynamic assignerId;
  @JsonKey(name: "comment_count")
  final int? commentCount;
  @JsonKey(name: "is_completed")
  final bool? isCompleted;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "priority")
  final int? priority;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "due")
  final Due? due;
  @JsonKey(name: "start_time")
  final DateTime? startTime;
  @JsonKey(name: "end_time")
  final DateTime? endTime;
  @JsonKey(name: "time_spent")
  final Duration? timeSpent;

  TaskResponse({
    this.creatorId,
    this.createdAt,
    this.assigneeId,
    this.assignerId,
    this.commentCount,
    this.isCompleted,
    this.content,
    this.description,
    this.sectionId,
    this.due,
    this.priority,
    this.id,
    this.startTime,
    this.endTime,
    this.timeSpent,
  });

  TaskResponse copyWith(
          {String? creatorId,
          DateTime? createdAt,
          dynamic assigneeId,
          dynamic assignerId,
          int? commentCount,
          bool? isCompleted,
          String? content,
          String? description,
          String? sectionId,
          int? priority,
          DateTime? startTime,
          DateTime? endTime,
          Duration? timeSpent,
          String? id}) =>
      TaskResponse(
        creatorId: creatorId ?? this.creatorId,
        createdAt: createdAt ?? this.createdAt,
        assigneeId: assigneeId ?? this.assigneeId,
        assignerId: assignerId ?? this.assignerId,
        commentCount: commentCount ?? this.commentCount,
        isCompleted: isCompleted ?? this.isCompleted,
        content: content ?? this.content,
        description: description ?? this.description,
        sectionId: sectionId ?? this.sectionId,
        priority: priority ?? this.priority,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        timeSpent: timeSpent ?? this.timeSpent,
        id: id ?? this.id,
      );

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}

@JsonSerializable()
class Due {
  @JsonKey(name: "date")
  final DateTime? date;
  @JsonKey(name: "is_recurring")
  final bool? isRecurring;
  @JsonKey(name: "datetime")
  final DateTime? datetime;
  @JsonKey(name: "string")
  final String? string;
  @JsonKey(name: "timezone")
  final String? timezone;
  @JsonKey(name: "id")
  final String? id;

  Due(
      {this.date,
      this.isRecurring,
      this.datetime,
      this.string,
      this.timezone,
      this.id});

  Due copyWith({
    DateTime? date,
    bool? isRecurring,
    DateTime? datetime,
    String? string,
    String? timezone,
  }) =>
      Due(
        date: date ?? this.date,
        isRecurring: isRecurring ?? this.isRecurring,
        datetime: datetime ?? this.datetime,
        string: string ?? this.string,
        timezone: timezone ?? this.timezone,
      );

  factory Due.fromJson(Map<String, dynamic> json) => _$DueFromJson(json);

  Map<String, dynamic> toJson() => _$DueToJson(this);
}
