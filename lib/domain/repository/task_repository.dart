import 'package:time_tracking_app/data/data_source/task_datasource.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';
import 'package:time_tracking_app/data/models/task_response.dart';

abstract class TaskRepository {
  Future<TaskResponse> createTask({required CreateTaskReq params});
  Future<TaskResponse> updateTask(
      {required String taskId, TaskResponse? params});
  Future<List<TaskResponse>> getTasks();
  Future<Comment> addComment({required Comment params});
  Future<List<Comment>> getComments({required String taskId});
}

class TaskRepositoryImp implements TaskRepository {
  TaskRepositoryImp(
    this.taskDataSource,
  );
  final TaskDatasource taskDataSource;

  @override
  Future<TaskResponse> createTask({required CreateTaskReq params}) {
    return taskDataSource.createTask(params: params);
  }

  @override
  Future<List<TaskResponse>> getTasks() {
    return taskDataSource.getTasks();
  }

  @override
  Future<Comment> addComment({required Comment params}) {
    return taskDataSource.addComment(params: params);
  }

  @override
  Future<List<Comment>> getComments({required String taskId}) {
    return taskDataSource.getComments(taskId: taskId);
  }

  @override
  Future<TaskResponse> updateTask(
      {required String taskId, TaskResponse? params}) {
    return taskDataSource.updateTask(taskId: taskId, params: params);
  }
}
