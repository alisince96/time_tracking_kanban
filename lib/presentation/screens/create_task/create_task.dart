import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/core/routing/page_path.dart';
import 'package:time_tracking_app/data/models/create_task_req.dart';
import 'package:time_tracking_app/presentation/screens/create_task/create_task_cubit.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/common_widgets/round_button.dart';
import 'package:time_tracking_app/shared/common_widgets/base_screen.dart';
import 'package:time_tracking_app/shared/common_widgets/custom_text_field.dart';
import 'package:time_tracking_app/shared/common_widgets/loader.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTaskCubit, GenericStates>(
      listener: (context, state) {
        if (state is ErrorState) {
          context.showSnackBar(state.message);
        } else if (state is CreateTaskSuccess) {
          context.read<TasksCubit>().getTasks();
          context.go(PagePath.bottomNavScreen);
        }
      },
      builder: (context, state) {
        return KeyboardDismisser(
          child: BaseScreen(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Create',
                            style: AppConsts.blackBold.copyWith(fontSize: 35)),
                        Text('New Task',
                            style: AppConsts.blackBold.copyWith(fontSize: 35)),
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
                          hintText: 'E.g Filters issue',
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
                          height: 40,
                        ),
                        RoundButton(
                          buttonColor: AppConsts.darkBlue,
                          buttonHeight: 55,
                          buttonWidth: context.width,
                          borderWidth: 0.0,
                          onPressed: () {
                            if (titleController.text.isEmpty) {
                              context.showSnackBar('Title cannot be empty');

                              return;
                            }
                            final params = CreateTaskReq(
                              content: titleController.text,
                              description: descriptionController.text,
                              createdAt: DateTime.now().toIso8601String(),
                            );
                            context.read<CreateTaskCubit>().createTask(params);
                          },
                          text: 'Create',
                          textStyle: AppConsts.whiteNormal25.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          borderRadius: 10,
                        ),
                        const SizedBox(
                          height: 50,
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
        );
      },
    );
  }
}
