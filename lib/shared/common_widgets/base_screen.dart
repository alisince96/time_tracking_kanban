import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key, required this.body, this.wantAppbar = true});
  final Widget body;
  final bool wantAppbar;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConsts.appGrey,
      appBar: widget.wantAppbar ? _buildAppBar(context) : null,
      body: widget.body,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppConsts.appGrey,
      leading: Visibility(
        visible: context.canPop(),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
    );
  }
}
