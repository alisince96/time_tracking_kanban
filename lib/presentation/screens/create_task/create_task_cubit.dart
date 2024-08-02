import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<GenericStates> {
  CreateTaskCubit(
    this.taskRepository,
  ) : super(InitialState());
  final TaskRepository taskRepository;

  // This method is responsible for creating a new task.
  // It takes a `CreateTaskReq` object as a parameter, which contains the details of the task to be created.
  // The method is `async` because it makes an asynchronous call to the `createTask` method of the `taskRepository` object.
  // Here's what the method does step by step:
  // 1. It emits a `LoadingState` object to indicate that the operation is in progress.
  // 2. It calls the `createTask` method of the `taskRepository` object and awaits the response.
  // 3. If the operation is successful, it emits a `CreateTaskSuccess` object with the response from the server.
  // 4. If an error occurs, it emits an `ErrorState` object with the error message.
  Future<void> createTask(CreateTaskReq createTaskReq) async {
    try {
      // Emit a LoadingState object to indicate that the operation is in progress.
      emit(LoadingState());

      // Call the createTask method of the taskRepository object to create the task.
      final response = await taskRepository.createTask(params: createTaskReq);

      // Emit a CreateTaskSuccess object with the result of the operation.
      emit(CreateTaskSuccess(response));
    } on DioException {
      // If there is a dio exception, emit an ErrorState with the error message.
      emit(ErrorState('No Internet Connection'));
    } catch (e) {
      // Emit an ErrorState object with the error message if an error occurs.
      emit(ErrorState(e.toString()));
    }
  }
}
