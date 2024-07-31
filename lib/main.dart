import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/routing/app_router.dart';
import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/presentation/screens/bottom_nav_bar/bottom_nav_bar_bloc_cubit.dart';
import 'package:time_tracking_app/presentation/screens/create_task/create_task_cubit.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details_cubit.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavBarCubit>(
            create: (context) => BottomNavBarCubit()),
        BlocProvider<CreateTaskCubit>(
            create: (context) => CreateTaskCubit(dependency<TaskRepository>())),
        BlocProvider<TasksCubit>(
            create: (context) => TasksCubit(dependency<TaskRepository>(),
                dependency<SharedPreferencesManager>())),
        BlocProvider<TaskDetailsCubit>(
            create: (context) =>
                TaskDetailsCubit(dependency<TaskRepository>())),
      ],
      child: MaterialApp.router(
        title: 'Tracker App',
        builder: (context, child) {
          return child ?? const SizedBox();
        },
        debugShowCheckedModeBanner: false,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
