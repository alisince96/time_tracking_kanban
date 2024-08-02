import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/presentation/screens/bottom_nav_bar/bottom_nav_item.dart';
import 'package:time_tracking_app/presentation/screens/bottom_nav_bar/bottom_nav_bar_bloc_cubit.dart';
import 'package:time_tracking_app/presentation/screens/completed_tasks/completed_tasks.dart';
import 'package:time_tracking_app/presentation/screens/tasks_dashboard/tasks_dashboard.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/images_path/images_path.dart';

class BottomNavScreen extends StatelessWidget {
  final List<BottomNavItem> _items = [
    BottomNavItem(
        label: 'Tasks', icon: ImagesPath.task, page: const TasksDashboard()),
    BottomNavItem(
        label: 'Completed',
        icon: ImagesPath.done,
        page: const CompletedTasks()),
  ];

  BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBarCubit, int>(
        builder: (context, index) {
          return _items[index].page;
        },
      ),
      bottomNavigationBar: BottomNavBar(items: _items),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;

  const BottomNavBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, int>(
      builder: (context, index) {
        return BottomNavigationBar(
          items: items.map((item) {
            return BottomNavigationBarItem(
              icon: Image.asset(
                item.icon,
                height: 30,
                width: 30,
              ),
              label: item.label,
            );
          }).toList(),
          currentIndex: index,
          backgroundColor: AppConsts.white,
          selectedItemColor: AppConsts.black,
          onTap: (newIndex) {
            context.read<BottomNavBarCubit>().changeIndex(newIndex);
          },
        );
      },
    );
  }
}
