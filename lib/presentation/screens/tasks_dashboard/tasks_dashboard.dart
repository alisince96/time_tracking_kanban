import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/core/routing/page_path.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details_cubit.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/common_widgets/loader.dart';
import 'package:time_tracking_app/shared/images_path/images_path.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class TasksDashboard extends StatefulWidget {
  const TasksDashboard({super.key});

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard> {
  Map<String, String> headers = {
    ImagesPath.todoList: 'To do',
    ImagesPath.progress: 'In Progress',
    ImagesPath.done: 'Done'
  };

  @override
  void initState() {
    super.initState();
    context.read<TasksCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, GenericStates>(
      listener: (context, state) {
        if (state is ErrorState) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppConsts.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Tracker App',
                                style: AppConsts.black26Normal15
                                    .copyWith(fontSize: 16),
                              ),
                              Text(
                                'Sprint#1',
                                style:
                                    AppConsts.blackBold.copyWith(fontSize: 22),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => context.push(PagePath.createTask),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppConsts.darkBlue),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: AppConsts.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is TasksFetched) ...[
                      Container(
                        height: context.height * 0.8,
                        decoration: const BoxDecoration(
                            color: AppConsts.appGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: DragAndDropLists(
                          children: List.generate(3, (index) {
                            return DragAndDropList(
                              contentsWhenEmpty: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text('No tasks',
                                      style: AppConsts.blackNormal15
                                          .copyWith(fontSize: 16)),
                                ),
                              ),
                              canDrag: false,
                              header: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: index == 0 ? 0 : 40,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 46,
                                          width: 46,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppConsts.white),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.asset(
                                              headers.keys.elementAt(index),
                                              height: 28,
                                              width: 28,
                                            ),
                                          )),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: index == 0
                                                    ? AppConsts.lightRed
                                                    : index == 1
                                                        ? AppConsts.splashColor
                                                        : AppConsts.greenish),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                headers.values.elementAt(index),
                                                style: AppConsts.blackNormal15
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppConsts.white),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              children: index == 0
                                  ? state.todoList
                                  : index == 1
                                      ? state.inProgressList
                                      : state.doneList,
                            );
                          }),
                          itemGhost: const SizedBox(
                            height: 250,
                          ),
                          listGhost: const SizedBox.shrink(),
                          onItemReorder: (a, b, c, d) {
                            onItemReorder(a, b, c, d, state);
                          },
                          onListReorder: (_, val) {},
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              if (state is LoadingState) const Loader()
            ],
          ),
        );
      },
    );
  }

  void onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex,
      int newListIndex, TasksFetched state) {
    switch (oldListIndex) {
      case 0:
        final movedItem = state.todoList.removeAt(oldItemIndex);
        switch (newListIndex) {
          case 0:
            state.todoList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 1);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 1:
            state.inProgressList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 2);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 2:
            state.doneList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 3);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
        }
      case 1:
        final movedItem = state.inProgressList.removeAt(oldItemIndex);
        switch (newListIndex) {
          case 0:
            state.todoList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 1);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 1:
            state.inProgressList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 2);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 2:
            state.doneList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 3);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
        }
      case 2:
        final movedItem = state.doneList.removeAt(oldItemIndex);
        switch (newListIndex) {
          case 0:
            state.todoList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 1);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 1:
            state.inProgressList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 2);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
          case 2:
            state.doneList.insert(newItemIndex, movedItem);
            final params = movedItem.task?.copyWith(priority: 3);
            context
                .read<TaskDetailsCubit>()
                .updateTask(taskId: movedItem.task?.id ?? '', params: params);
            break;
        }
    }
    setState(() {});
  }
}
