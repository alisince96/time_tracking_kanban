import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/data/data_source/task_datasource.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';

import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/presentation/screens/create_task/create_task_cubit.dart';

import 'tasks_tests.mocks.dart';

@GenerateMocks([
  TaskRepository,
  SharedPreferencesManager,
  Dio,
  TaskDatasource,
  BaseOptions
])
void main() {
  late TaskRepository mockTaskRepository;
  late CreateTaskCubit tasksCubit;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    tasksCubit = CreateTaskCubit(mockTaskRepository);
  });

  group('CreateTasksCubit', () {
    test('emits [CreateTaskSuccess] when createTask is called', () async {
      // Arrange
      final task = TaskResponse(
        id: '1',
        content: 'Task 1',
        description: 'Description 1',
        priority: 1,
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
      );

      final params = CreateTaskReq(
        content: 'Task 1',
        sectionId: '1',
        description: 'Description 1',
      );
      when(mockTaskRepository.createTask(params: params))
          .thenAnswer((_) async => task);

      // Act
      await tasksCubit.createTask(
        params,
      );

      // Assert
      expect(tasksCubit.state, isA<CreateTaskSuccess>());
    });
  });
}
