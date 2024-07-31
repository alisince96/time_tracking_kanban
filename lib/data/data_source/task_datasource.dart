
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/shared/network/client/rest_api_client.dart';

abstract class TaskDatasource {
  Future<TaskResponse> createTask({required CreateTaskReq params});
  Future<TaskResponse> updateTask(
      {required String taskId, TaskResponse? params});
  Future<List<TaskResponse>> getTasks();
  Future<Comment> addComment({required Comment params});
  Future<List<Comment>> getComments({required String taskId});
}

class TaskDatasourceImpl implements TaskDatasource {
  TaskDatasourceImpl(
    this._restClient,
  );

  final RestAPIClient _restClient;

  @override
  Future<TaskResponse> createTask({required CreateTaskReq params}) {
    return _restClient.createTask(params: params);
  }

  @override
  Future<List<TaskResponse>> getTasks() {
    return _restClient.getTasks();
  }

  @override
  Future<Comment> addComment({required Comment params}) {
    return _restClient.addComment(params: params);
  }

  @override
  Future<List<Comment>> getComments({required String taskId}) {
    return _restClient.getComments(taskId: taskId);
  }

  @override
  Future<TaskResponse> updateTask(
      {required String taskId, TaskResponse? params}) {
    return _restClient.updateTask(taskId: taskId, params: params);
  }
}
