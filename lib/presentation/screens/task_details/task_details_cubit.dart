import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<GenericStates> {
  TaskDetailsCubit(this.taskRepository) : super(TaskDetailsInitial());
  final TaskRepository taskRepository;
  // This method is responsible for adding a new comment to a task.
  // It takes in a Comment object as a parameter which contains the details of the comment.
  //
  // The method first emits a LoadingState object to indicate to the UI that it is performing
  // some operation.
  //
  // It then calls the addComment method of the taskRepository object, passing in the Comment object.
  // This method returns a Future object which represents the result of the operation.
  //
  // Once the result is available, the method emits a CommentAddedSuccess object with the result
  // of the operation. If any error occurs during the operation, the method emits an ErrorState
  // object with the error message.
  //
  // Note: The taskRepository object is responsible for communicating with the data source
  // (e.g., the database or API) to perform the actual operation.
  Future<void> addComment(Comment params) async {
    try {
      // Emit a LoadingState object to indicate that the operation is in progress.
      emit(LoadingState());

      // Call the addComment method of the taskRepository object to add the comment to the task.
      final response = await taskRepository.addComment(params: params);

      // Emit a CommentAddedSuccess object with the result of the operation.
      emit(CommentAddedSuccess(response));
    } on DioException {
      // If there is a dio exception, emit an ErrorState with the error message.
      emit(ErrorState('No Internet Connection'));
    } catch (e) {
      // Emit an ErrorState object with the error message if an error occurs.
      emit(ErrorState(e.toString()));
    }
  }

  // This method is responsible for fetching the comments associated with a task.
  //
  // It takes in a String parameter called taskId which represents the ID of the task for which
  // we want to fetch the comments.
  //
  // The method first emits a LoadingState object to indicate to the UI that it is performing
  // some operation.
  //
  // It then calls the getComments method of the taskRepository object, passing in the taskId.
  // This method returns a Future object which represents the result of the operation.
  //
  // Once the result is available, the method emits a CommentsFetched object with the result of
  // the operation. The result is a list of Comment objects.
  //
  // If any error occurs during the operation, the method emits an ErrorState object with the
  // error message.
  //
  // Note: The taskRepository object is responsible for communicating with the data source
  // (e.g., the database or API) to perform the actual operation.
  Future<void> getComments(String taskId) async {
    try {
      // Emit a LoadingState object to indicate that the operation is in progress.
      emit(LoadingState());

      // Call the getComments method of the taskRepository object to fetch the comments.
      // The taskId parameter is used to identify the task for which we want to fetch the comments.
      final response = await taskRepository.getComments(taskId: taskId);

      // Emit a CommentsFetched object with the result of the operation.
      // The result is a list of Comment objects.
      emit(CommentsFetched(comments: response));
    } on DioException {
      // If there is a dio exception, emit an ErrorState with the error message.
      emit(ErrorState('No Internet Connection'));
    } catch (e) {
      // Emit an ErrorState object with the error message if an error occurs.
      // The error message is obtained by calling the toString() method on the exception object.
      emit(ErrorState(e.toString()));
    }
  }

  // This method is responsible for updating a task.
  //
  // It takes in two required parameters:
  // - taskId: a String representing the ID of the task to be updated.
  // - params: an optional TaskResponse object representing the updated task details.
  //
  // The method first emits a LoadingState object to indicate to the UI that it is performing
  // some operation.
  //
  // It then calls the updateTask method of the taskRepository object, passing in the taskId and
  // params. This method returns a Future object which represents the result of the operation.
  //
  // Once the result is available, the method emits a TaskUpdated object with the result of
  // the operation. The result is a TaskResponse object representing the updated task.
  //
  // If any error occurs during the operation, the method emits an ErrorState object with the
  // error message.
  //
  // Note: The taskRepository object is responsible for communicating with the data source
  // (e.g., the database or API) to perform the actual operation.
  Future<void> updateTask(
      {required String taskId, TaskResponse? params}) async {
    try {
      // Emit a LoadingState object to indicate that the operation is in progress.
      emit(LoadingState());

      // Call the updateTask method of the taskRepository object, passing in the taskId and
      // params.
      // This method returns a Future object which represents the result of the operation.
      final response =
          await taskRepository.updateTask(taskId: taskId, params: params);

      // Emit a TaskUpdated object with the result of the operation.
      // The result is a TaskResponse object representing the updated task.
      emit(TaskUpdated(response));
    } on DioException {
      // If there is a dio exception, emit an ErrorState with the error message.
      emit(ErrorState('No Internet Connection'));
    } catch (e) {
      // Emit an ErrorState object with the error message if an error occurs.
      // The error message is obtained by calling the toString() method on the exception object.
      emit(ErrorState(e.toString()));
    }
  }
}
