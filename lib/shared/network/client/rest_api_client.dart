import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/shared/network/endpoints/endpoints.dart';

part 'rest_api_client.g.dart';

@RestApi()
abstract class RestAPIClient {
  factory RestAPIClient(Dio dio, {String baseUrl}) = _RestAPIClient;

  @POST(Endpoints.tasks)
  Future<TaskResponse> createTask({
    @Body() required CreateTaskReq params,
  });
  @POST(Endpoints.updateTask)
  Future<TaskResponse> updateTask({
    @Path('task_id') required String taskId,
    @Body() TaskResponse? params,
  });
  @GET(Endpoints.tasks)
  Future<List<TaskResponse>> getTasks(
      //   {
      //   @Query('section_id') required String sectionId,
      // }
      );
  @POST(Endpoints.comments)
  Future<Comment> addComment({
    @Body() required Comment params,
  });
  @GET(Endpoints.comments)
  Future<List<Comment>> getComments({
    @Query('task_id') required String taskId,
  });
}
