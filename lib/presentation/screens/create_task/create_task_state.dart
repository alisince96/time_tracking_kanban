part of 'create_task_cubit.dart';

abstract class CreateTaskState extends GenericStates {}

class CreateTaskSuccess extends CreateTaskState {
  final TaskResponse taskResponse;
  CreateTaskSuccess(this.taskResponse);
}
