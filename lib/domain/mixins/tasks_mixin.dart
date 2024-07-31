import 'package:flutter/widgets.dart';
import 'package:time_tracking_app/core/routing/app_router.dart';
import 'package:time_tracking_app/data/models/drage_drop_item_extended.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/shared/common_widgets/task_card.dart';

mixin TasksMixin {
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
}
