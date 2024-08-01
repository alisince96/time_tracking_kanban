import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/data/data_source/task_datasource.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';

import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details_cubit.dart';

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
  late TaskDetailsCubit tasksCubit;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    tasksCubit = TaskDetailsCubit(mockTaskRepository);
  });

  group('TaskDetailsCubit', () {
    test('emits [TaskUpdated] when updateTask is called', () async {
      // Arrange
      final task = TaskResponse(
        id: '1',
        content: 'Task 1',
        description: 'Description 1',
        priority: 1,
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        timeSpent: const Duration(hours: 1),
      );

      when(mockTaskRepository.updateTask(taskId: '1', params: task))
          .thenAnswer((_) async => task);

      // Act
      await tasksCubit.updateTask(
        taskId: '1',
        params: task,
      );

      // Assert
      expect(tasksCubit.state, isA<TaskUpdated>());
    });

    test('emits [CommentsFetched] when getComments is called', () async {
      // Arrange
      final comment = Comment(
        id: '1',
        content: 'Comment 1',
        taskId: '1',
      );

      when(mockTaskRepository.getComments(taskId: '1'))
          .thenAnswer((_) async => [comment]);

      // Act
      await tasksCubit.getComments(
        '1',
      );

      // Assert
      expect(tasksCubit.state, isA<CommentsFetched>());
    });

    test('emits [CommentAddedSuccess] when addComment is called', () async {
      // Arrange
      final comment = Comment(
        id: '1',
        content: 'Comment 1',
        taskId: '1',
      );

      when(mockTaskRepository.addComment(params: comment))
          .thenAnswer((_) async => comment);

      // Act
      await tasksCubit.addComment(
        comment,
      );

      // Assert
      expect(tasksCubit.state, isA<CommentAddedSuccess>());
    });
  });
}
