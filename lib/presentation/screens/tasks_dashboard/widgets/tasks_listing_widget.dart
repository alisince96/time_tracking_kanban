import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/domain/mixins/tasks_mixin.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class TasksListingWidget extends StatefulWidget {
  const TasksListingWidget({super.key});

  @override
  State<TasksListingWidget> createState() => _TasksListingWidgetState();
}

class _TasksListingWidgetState extends State<TasksListingWidget>
    with TasksMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, GenericStates>(
      builder: (context, state) {
        if (state is TasksFetched) {
          return Container(
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
                          style:
                              AppConsts.blackNormal15.copyWith(fontSize: 16)),
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
                                    borderRadius: BorderRadius.circular(5),
                                    color: index == 0
                                        ? AppConsts.lightRed
                                        : index == 1
                                            ? AppConsts.splashColor
                                            : AppConsts.greenish),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Text(
                                    headers.values.elementAt(index),
                                    style: AppConsts.blackNormal15.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                onItemReorder(a, b, c, d, state, context);
                setState(() {});
              },
              onListReorder: (_, val) {},
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
