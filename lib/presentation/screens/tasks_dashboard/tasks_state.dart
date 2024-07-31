part of 'tasks_cubit.dart';

abstract class TasksState extends GenericStates {}

class TasksInitial extends TasksState {}

class TasksFetched extends TasksState {
  final List<DrageDropItemExtended> todoList;
  final List<DrageDropItemExtended> inProgressList;
  final List<DrageDropItemExtended> doneList;
  TasksFetched({
    required this.todoList,
    required this.inProgressList,
    required this.doneList,
  });
}
