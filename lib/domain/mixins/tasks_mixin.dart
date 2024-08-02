import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/routing/app_router.dart';
import 'package:time_tracking_app/data/models/drage_drop_item_extended.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details_cubit.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/shared/common_widgets/task_card.dart';
import 'package:time_tracking_app/shared/images_path/images_path.dart';

mixin TasksMixin {
  Map<String, String> headers = {
    ImagesPath.todoList: 'To do',
    ImagesPath.progress: 'In Progress',
    ImagesPath.done: 'Done'
  };
  void openTaskDetailsSheet(TaskResponse task) {
    AppRouter.ctx?.showBottomSheet(
        isScrollControlled: true,
        color: AppConsts.appGrey,
        padding: EdgeInsets.zero,
        builder: (context) => TaskDetails(
              task: task,
            ));
  }

  // This function takes a list of TaskResponse objects and transforms them into
  // a new list of DrageDropItemExtended objects.
  //
  // Each TaskResponse object is transformed into a DrageDropItemExtended object
  // by mapping over the list of TaskResponse objects.
  //
  // In the mapping function, a new DrageDropItemExtended object is created with
  // the current TaskResponse object as the 'task' property.
  //
  // The child property of the DrageDropItemExtended object is a TaskCard widget.
  // The TaskCard widget is created with the current TaskResponse object as the
  // 'task' property
  //
  // The onTap property of the TaskCard widget is a function that opens a bottom
  // sheet when tapped. The function takes the current TaskResponse object
  // and calls the openTaskDetailsSheet function with it as an argument.
  //
  // The toList function is called on the mapped list to transform it into a
  // List<DrageDropItemExtended> object.
  List<DrageDropItemExtended> toDragAndDropItems(List<TaskResponse> tasks) {
    return tasks
        .map((task) => DrageDropItemExtended(
            task: task,
            child: TaskCard(
              task: task,
              padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
              onTap: () => openTaskDetailsSheet(task),
            )))
        .toList();
  }

  // This function handles the reordering of items in the drag and drop list
  // widget.
  //
  // It takes in the old and new indices of the item, the old and new list
  // indices, the current state of the tasks, and the build context.
  //
  // Based on the old list index, it determines which list the item is currently
  // in (todo, in progress, or done). It removes the item from that list at the
  // old index and stores it in the movedItem variable.
  //
  // Based on the new list index, it determines where the item should be moved to
  // (todo, in progress, or done). It inserts the moved item into that list at
  // the new index.
  //
  // For each case, it updates the priority of the task in the moved item to
  // reflect the new list it is in. It then calls the updateTask function of the
  // TaskDetailsCubit with the taskId and the updated task parameters.
  void onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex,
      int newListIndex, TasksFetched state, BuildContext context) {
    // Determine the list the item is currently in based on the old list index
    switch (oldListIndex) {
      case 0:
        // The item is in the todo list
        final movedItem = state.todoList.removeAt(oldItemIndex);
        switch (newListIndex) {
          case 0:
            // The item should be moved to the todo list
            state.todoList.insert(newItemIndex, movedItem);
            // Update the priority of the task to reflect the new list it is in
            final params = movedItem.task?.copyWith(priority: 1);
            // Call the updateTask function of the TaskDetailsCubit
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 1:
            // The item should be moved to the in progress list
            state.inProgressList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 2);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 2:
            // The item should be moved to the done list
            state.doneList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 3);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
        }
        break;
      case 1:
        // The item is in the in progress list
        final movedItem = state.inProgressList.removeAt(oldItemIndex);
        switch (newListIndex) {
          case 0:
            // The item should be moved to the todo list
            state.todoList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 1);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 1:
            // The item should be moved to the in progress list
            state.inProgressList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 2);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 2:
            // The item should be moved to the done list
            state.doneList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 3);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
        }
        break;
      case 2:
        // The item is in the done list
        final movedItem = state.doneList.removeAt(oldItemIndex);
        switch (newListIndex) {
          case 0:
            // The item should be moved to the todo list
            state.todoList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 1);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 1:
            // The item should be moved to the in progress list
            state.inProgressList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 2);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 2:
            // The item should be moved to the done list
            state.doneList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 3);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
        }
        break;
    }
  }
}
