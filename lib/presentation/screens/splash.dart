import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_tracking_app/core/routing/page_path.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.go(PagePath.bottomNavScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConsts.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText('Time', context),
            _buildTitleText('Tracker', context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleText(String text, BuildContext context) {
    return Text(text, style: AppConsts.whiteBold50.copyWith(fontSize: 35));
  }
}
