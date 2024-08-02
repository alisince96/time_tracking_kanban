import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/mixins/tasks_mixin.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';

import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

import 'package:time_tracking_app/shared/common_widgets/base_screen.dart';
import 'package:time_tracking_app/shared/common_widgets/task_card.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> with TasksMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, GenericStates>(
      builder: (context, state) {
        return BaseScreen(
          wantAppbar: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text('Completed',
                        style: AppConsts.blackBold.copyWith(fontSize: 35)),
                    Text('Tasks',
                        style: AppConsts.blackBold.copyWith(fontSize: 35)),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is TasksFetched)
                      ListView.builder(
                          itemCount: state.doneList.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final task =
                                state.doneList[index].task ?? TaskResponse();
                            return TaskCard(
                              task: task,
                              onTap: () => openTaskDetailsSheet(task),
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                            );
                          }),
                    if (state is TasksFetched && state.doneList.isEmpty)
                      SizedBox(
                        height: context.height * 0.5,
                        child: Center(
                          child: Text('No tasks yet',
                              style: AppConsts.blackNormal15
                                  .copyWith(fontSize: 20)),
                        ),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
