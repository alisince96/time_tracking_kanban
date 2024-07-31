import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/data/models/drage_drop_item_extended.dart';

import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';

import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockSharedPreferencesManager extends Mock
    implements SharedPreferencesManager {}

@GenerateMocks([TaskRepository, SharedPreferencesManager])
void main() {
  group('TasksCubit', () {
    late TasksCubit tasksCubit;
    late MockTaskRepository mockTaskRepository;
    late MockSharedPreferencesManager mockPreferencesManager;

    setUp(() {
      mockTaskRepository = MockTaskRepository();
      mockPreferencesManager = MockSharedPreferencesManager();
      tasksCubit = TasksCubit(mockTaskRepository, mockPreferencesManager);
    });

    // test('emits [LoadingState, TasksFetched] when getTasks is successful', () {
    final mockTasks = [
      TaskResponse(id: '1', content: 'Task 1', priority: 1),
      TaskResponse(id: '2', content: 'Task 2', priority: 2),
      TaskResponse(id: '3', content: 'Task 3', priority: 3),
    ];
    // when(() => mockTaskRepository.getTasks())
    //     .thenAnswer((_) => Future.value(mockTasks));

    blocTest<TasksCubit, GenericStates>(
      'emits [LoadingState, TasksFetched] when getTasks is successful',
      build: () => tasksCubit,
      act: (cubit) => cubit.getTasks(),
      expect: () => [
        LoadingState(),
        TasksFetched(
          todoList: mockTasks
              .where((task) => task.priority == 1)
              .map((task) =>
                  DrageDropItemExtended(task: task, child: const SizedBox()))
              .toList(),
          inProgressList: mockTasks
              .where((task) => task.priority == 1)
              .map((task) =>
                  DrageDropItemExtended(task: task, child: const SizedBox()))
              .toList(),
          doneList: mockTasks
              .where((task) => task.priority == 1)
              .map((task) =>
                  DrageDropItemExtended(task: task, child: const SizedBox()))
              .toList(),
        ),
      ],
    );
    //});

    // test('emits [LoadingState, ErrorState] when getTasks throws an error', () {
    final error = Exception('Failed to fetch tasks');

    // when(() => mockTaskRepository.getTasks()).thenThrow(error);

    blocTest<TasksCubit, GenericStates>(
      'emits [LoadingState, ErrorState] when getTasks throws an error',
      build: () => tasksCubit,
      act: (cubit) => cubit.getTasks(),
      expect: () => [LoadingState(), ErrorState(error.toString())],
    );
    // });
  });
}
