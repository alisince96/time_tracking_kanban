import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_tracking_app/core/routing/page_path.dart';
import 'package:time_tracking_app/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:time_tracking_app/presentation/screens/create_task/create_task.dart';
import 'package:time_tracking_app/presentation/screens/splash.dart';

///Global Key for the navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<OverlayState> overlayState = GlobalKey<OverlayState>();

class AppRouter {
  AppRouter._();

  static BuildContext? get ctx =>
      router.routerDelegate.navigatorKey.currentContext;

  static String get currentLocation {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final location = matchList.uri.toString();
    return location;
  }

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: PagePath.splash,
    debugLogDiagnostics: kDebugMode,
    errorBuilder: (context, state) => const SizedBox(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: PagePath.bottomNavScreen,
        builder: (context, state) {
          return BottomNavScreen();
        },
      ),
      GoRoute(
        path: PagePath.createTask,
        builder: (context, state) {
          return const CreateTask();
        },
      ),
    ],
  );
}
