part of 'task_details_cubit.dart';

abstract class TaskDetailsState {}

class TaskDetailsInitial extends GenericStates {}

class CommentAddedSuccess extends GenericStates {
  final Comment response;
  CommentAddedSuccess(this.response);
}

class CommentsFetched extends GenericStates {
  final List<Comment> comments;
  CommentsFetched({required this.comments});
}

class TaskUpdated extends GenericStates {
  final TaskResponse response;
  TaskUpdated(this.response);
}
