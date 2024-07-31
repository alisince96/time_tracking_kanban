import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/data/models/drage_drop_item_extended.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/mixins/tasks_mixin.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';

import 'package:time_tracking_app/shared/states/generic_states.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<GenericStates> with TasksMixin {
  TasksCubit(this.taskRepository, this.preferencesManager)
      : super(InitialState());
  final TaskRepository taskRepository;
  final SharedPreferencesManager preferencesManager;
  List<DrageDropItemExtended> todoList = [];
  List<DrageDropItemExtended> inProgressList = [];
  List<DrageDropItemExtended> doneList = [];

  // This function is responsible for fetching tasks from the task repository.
  // It emits different states during its execution:
  // - LoadingState: when the function starts fetching tasks.
  // - TasksFetched: when the function successfully fetches tasks and prepares them for display.
  // - ErrorState: when there is an error while fetching tasks.
  void getTasks() async {
    try {
      // Emit a LoadingState to indicate that tasks are being fetched.
      emit(LoadingState());

      // Clear the lists of tasks to prevent duplication.
      todoList.clear();
      inProgressList.clear();
      doneList.clear();

      // Fetch tasks from the task repository.
      final response = await taskRepository.getTasks();

      // Filter tasks based on their status e.g Todo, In Progress, Done.
      final todo = response.where((task) => task.priority == 1).toList();
      final inProgress = response.where((task) => task.priority == 2).toList();
      final done = response.where((task) => task.priority == 3).toList();

      // Fetch task durations for the filtered tasks in parallel.
      await (_fetchTaskDurations(todo));
      await (_fetchTaskDurations(inProgress));
      await (_fetchTaskDurations(done));

      // Convert the filtered tasks to drag and drop items.
      todoList = toDragAndDropItems(todo);
      inProgressList = toDragAndDropItems(inProgress);
      doneList = toDragAndDropItems(done);

      // Emit a TasksFetched state with the prepared tasks.
      emit(TasksFetched(
          todoList: todoList,
          inProgressList: inProgressList,
          doneList: doneList));
    } catch (e) {
      // If there is an error, emit an ErrorState with the error message.
      emit(ErrorState(e.toString()));
    }
  }

  /// This function fetches the task durations for each task in the list
  /// and updates the task list with the fetched durations.
  ///
  /// The task list is passed as an argument and is modified in place.
  /// The tasks are fetched from the shared preferences and their durations
  /// are checked for existence. If the task has a duration stored, it is
  /// updated with the stored duration.
  Future<void> _fetchTaskDurations(List<TaskResponse> taskList) async {
    // Iterate over each task in the task list.
    for (int i = 0; i < taskList.length; i++) {
      // Get the id of the current task.
      final taskId = taskList[i].id ?? '';

      // Retrieve the JSON string of the stored task from the shared preferences.
      final storedTaskJson = await preferencesManager.retrieveString(taskId);

      // Check if there is a stored task.
      if (storedTaskJson != null) {
        // Decode the stored task JSON string into a TaskResponse object.
        final storedTask = TaskResponse.fromJson(jsonDecode(storedTaskJson));

        // Update the current task in the task list with the stored task's
        // duration, start time, and end time.
        taskList[i] = taskList[i].copyWith(
          timeSpent: storedTask.timeSpent,
          startTime: storedTask.startTime,
          endTime: storedTask.endTime,
        );
      }
    }
  }

  // This function updates the duration of a task in the shared preferences.
  //
  // The function takes three parameters:
  // - startTime: An optional DateTime object representing the start time of the task.
  // - endTime: An optional DateTime object representing the end time of the task.
  // - task: A required TaskResponse object representing the task to update.
  //
  // The function first checks if both startTime and endTime are null. If so, it
  // returns early without doing anything.
  //
  // If startTime and endTime are not null, the function calculates the duration
  // between startTime and endTime using the difference method of DateTime.
  // It then updates the task object with the calculated duration using the
  // copyWith method of TaskResponse.
  //
  // Next, the function creates a new TaskResponse object called updatedTask
  // by copying the task object and updating its startTime and endTime fields
  // with the provided startTime and endTime parameters.
  //
  // The function then gets the id of the task object and stores it in a variable
  // called taskId. If the task object does not have an id, it assigns an empty
  // string to taskId.
  //
  // The function converts the updatedTask object to a JSON string using the
  // toJson method of TaskResponse. It then stores the JSON string in the
  // shared preferences using the storeString method of the preferencesManager
  // object.
  void updateTaskDuration(
      {DateTime? startTime, DateTime? endTime, required TaskResponse task}) {
    // If both startTime and endTime are null, return early without doing anything.
    if (startTime == null && endTime == null) {
      return;
    }

    // If startTime and endTime are not null, calculate the duration between them.
    if (startTime != null && endTime != null) {
      // Calculate the duration between startTime and endTime.
      final durationBetweenStartAndEnd = endTime.difference(startTime);

      // Update the task object with the calculated duration.
      task = task.copyWith(timeSpent: durationBetweenStartAndEnd);
    }

    // Create a new TaskResponse object called updatedTask by copying the task
    // object and updating its startTime and endTime fields with the provided
    // startTime and endTime parameters.
    final updatedTask = task.copyWith(
      startTime: startTime,
      endTime: endTime,
    );

    // Get the id of the task object and store it in a variable called taskId.
    // If the task object does not have an id, assign an empty string to taskId.
    final taskId = task.id ?? '';

    // Convert the updatedTask object to a JSON string.
    final updatedTaskJson = updatedTask.toJson();

    // Store the JSON string in the shared preferences using the storeString
    // method of the preferencesManager object.
    preferencesManager.storeString(taskId, jsonEncode(updatedTaskJson));
  }
}
