import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/domain/mixins/date_time_selection_mixin.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details_cubit.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/common_widgets/loader.dart';
import 'package:time_tracking_app/shared/common_widgets/round_button.dart';
import 'package:time_tracking_app/shared/common_widgets/base_screen.dart';
import 'package:time_tracking_app/shared/common_widgets/custom_text_field.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key, required this.task});
  final TaskResponse task;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> with DateTimePickerMixin {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  List<Comment> comments = [];
  @override
  @override
  void initState() {
    final task = widget.task;
    titleController.text = task.content ?? '';
    descriptionController.text = task.description ?? '';

    startDate = task.startTime;
    endDate = task.endTime;
    startDateController.text = task.startTime?.toString() ?? '';
    endDateController.text = task.endTime?.toString() ?? '';

    context.read<TaskDetailsCubit>().getComments(task.id ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskDetailsCubit, GenericStates>(
      listener: (context, state) {
        if (state is ErrorState) {
          context.showSnackBar(state.message);
        } else if (state is CommentAddedSuccess) {
          commentController.clear();
          context.read<TaskDetailsCubit>().getComments(widget.task.id ?? '');
        } else if (state is TaskUpdated) {
          context.read<TasksCubit>().getTasks();
          context.pop();
        } else if (state is CommentsFetched) {
          comments = state.comments;
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: KeyboardDismisser(
            child: BaseScreen(
              wantAppbar: false,
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Text('Task',
                              style:
                                  AppConsts.blackBold.copyWith(fontSize: 35)),
                          Text('Details',
                              style:
                                  AppConsts.blackBold.copyWith(fontSize: 35)),
                          const SizedBox(
                            height: 50,
                          ),
                          Text('Title',
                              style: AppConsts.blackNormal25.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: titleController,
                            hintText: 'Task title',
                            hintStyle: TextStyle(
                                color: AppConsts.greyish.withOpacity(0.5),
                                fontSize: 14),
                            horizontalMargin: 0,
                            borderColor: Colors.transparent,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Description',
                              style: AppConsts.blackNormal25.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: descriptionController,
                            hintText: 'Task description',
                            horizontalMargin: 0,
                            hintStyle: TextStyle(
                                color: AppConsts.greyish.withOpacity(0.5),
                                fontSize: 14),
                            borderColor: Colors.transparent,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text('Start Time',
                              style: AppConsts.blackNormal25.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: startDateController,
                            hintText: '2 Aug 5:00 PM',
                            readOnly: true,
                            onTap: () {
                              showCustomDateTimePicker(
                                context,
                                minimumDate: DateTime.now()
                                    .subtract(const Duration(days: 365)),
                                maximumDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                                onConfirm: (date) {
                                  startDate = date;
                                  startDateController.text = date.toString();
                                },
                                initialDate: DateTime.now(),
                              );
                            },
                            hintStyle: TextStyle(
                                color: AppConsts.greyish.withOpacity(0.5),
                                fontSize: 14),
                            horizontalMargin: 0,
                            borderColor: Colors.transparent,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text('End Time',
                              style: AppConsts.blackNormal25.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: endDateController,
                            hintText: '3 Aug 5:00 PM',
                            readOnly: true,
                            onTap: () {
                              showCustomDateTimePicker(
                                context,
                                minimumDate: DateTime(2023, 3, 5),
                                maximumDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                                onConfirm: (date) {
                                  endDate = date;
                                  endDateController.text = date.toString();
                                },
                                initialDate: DateTime.now(),
                              );
                            },
                            hintStyle: TextStyle(
                                color: AppConsts.greyish.withOpacity(0.5),
                                fontSize: 14),
                            horizontalMargin: 0,
                            borderColor: Colors.transparent,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text('Add Comment',
                              style: AppConsts.blackNormal25.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: commentController,
                            hintText: 'Comment',
                            horizontalMargin: 0,
                            hintStyle: TextStyle(
                                color: AppConsts.greyish.withOpacity(0.5),
                                fontSize: 14),
                            borderColor: Colors.transparent,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                final params = Comment(
                                    content: commentController.text,
                                    taskId: widget.task.id,
                                    postedAt: DateTime.now());
                                context
                                    .read<TaskDetailsCubit>()
                                    .addComment(params);
                              },
                              child: Icon(Icons.send,
                                  color: commentController.text.isNotEmpty
                                      ? AppConsts.darkBlue
                                      : AppConsts.greyish),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: comments.isNotEmpty,
                            child: Text('All Comments',
                                style: AppConsts.blackNormal25.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppConsts.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(comments[index].content ?? '',
                                              style: AppConsts.blackNormal25
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  comments[index]
                                                          .postedAt
                                                          ?.toIso8601String()
                                                          .split('T')
                                                          .first ??
                                                      '',
                                                  style: AppConsts.greyNormal15
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: comments.length),
                          SizedBox(
                            height: context.height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 25,
                    child: Container(
                      height: 80,
                      color: AppConsts.appGrey,
                      width: context.width,
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppConsts.greyish.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                                onTap: () => context.pop(),
                                child: const Icon(Icons.close)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 25,
                    right: 25,
                    child: Container(
                      height: 90,
                      width: context.width,
                      color: AppConsts.appGrey,
                      child: Column(
                        children: [
                          RoundButton(
                            buttonColor: AppConsts.darkBlue,
                            buttonHeight: 55,
                            buttonWidth: context.width,
                            borderWidth: 0.0,
                            onPressed: () async {
                              final params = TaskResponse(
                                id: widget.task.id,
                                content: titleController.text,
                                description: descriptionController.text,
                              );
                              context.read<TaskDetailsCubit>().updateTask(
                                  taskId: widget.task.id ?? '', params: params);
                              context.read<TasksCubit>().updateTaskDuration(
                                    task: widget.task,
                                    startTime: startDate,
                                    endTime: endDate,
                                  );
                            },
                            text: 'Update',
                            textStyle: AppConsts.whiteNormal25.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            borderRadius: 10,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: state is LoadingState, child: const Loader())
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
