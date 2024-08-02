import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/core/routing/page_path.dart';
import 'package:time_tracking_app/domain/mixins/tasks_mixin.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/widgets/tasks_listing_widget.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/common_widgets/loader.dart';
import 'package:time_tracking_app/shared/states/generic_states.dart';

class TasksDashboard extends StatefulWidget {
  const TasksDashboard({super.key});

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard> with TasksMixin {
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
                    const TasksListingWidget()
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
}
