import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/data/data_source/task_datasource.dart';

import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

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
  late TasksCubit tasksCubit;
  late SharedPreferencesManager mockSharedPreferencesManager;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    mockSharedPreferencesManager = MockSharedPreferencesManager();
    tasksCubit = TasksCubit(mockTaskRepository, mockSharedPreferencesManager);
  });

  group('TasksCubit', () {
    test('emits [TasksFetched] when getTasks is called', () async {
      // Arrange
      final task = TaskResponse(
        id: '1',
        content: 'Task 1',
        description: 'Description 1',
        priority: 1,
      );
      final expectedTasks = [task];

      when(mockTaskRepository.getTasks()).thenAnswer((_) async {
        when(mockSharedPreferencesManager.retrieveString('1'))
            .thenAnswer((_) async => null);
        return expectedTasks;
      });

      // Act
      await tasksCubit.getTasks();

      // Assert
      expect(tasksCubit.state, isA<TasksFetched>());
    });
  });
}
