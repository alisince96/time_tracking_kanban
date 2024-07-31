import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/presentation/screens/create_task/create_task_cubit.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class MockTaskRepository extends Mock implements TaskRepository {
  @override
  Future<TaskResponse> createTask({required CreateTaskReq params}) {
    // TODO: implement createTask
    throw UnimplementedError();
  }
}

void main() {
  group('CreateTaskCubit', () {
    MockTaskRepository taskRepository;
    CreateTaskCubit createTaskCubit;
    taskRepository = MockTaskRepository();
    createTaskCubit = CreateTaskCubit(taskRepository);

    setUp(() {
      taskRepository = MockTaskRepository();
      createTaskCubit = CreateTaskCubit(taskRepository);
    });

    blocTest<CreateTaskCubit, GenericStates>(
      'emits [LoadingState] when createTask is called',
      build: () => createTaskCubit,
      act: (cubit) => cubit.createTask(CreateTaskReq(
        content: 'filter task',
        sectionId: AppConsts.todoSectionId,
      )),
      expect: () => [LoadingState(), ErrorState('')],
    );

    // blocTest<CreateTaskCubit, CreateTaskState>(
    //   'emits [ErrorState] when createTask throws',
    //   build: () {
    //     when(() => taskRepository.createTask(
    //             params: CreateTaskReq(
    //           name: 'filter task',
    //           sectionId: AppConsts.todoSectionId,
    //         ))).thenThrow(Exception('error'));

    //     return createTaskCubit;
    //   },
    //   act: (cubit) => cubit.createTask(CreateTaskReq(
    //     name: 'filter task',
    //     sectionId: AppConsts.todoSectionId,
    //   )),
    //   expect: () => [LoadingState(), ErrorState('')],
    // );
  });
}
