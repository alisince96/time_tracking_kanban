import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class Loader extends StatelessWidget {
  const Loader(
      {super.key, this.backgroundColor, this.height, this.blurVal = 5});
  final Color? backgroundColor;
  final double? height;
  final double blurVal;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurVal,
        sigmaY: blurVal,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Center(
          child: LoadingAnimationWidget.waveDots(
            color: backgroundColor ?? AppConsts.darkBlue,
            size: 85,
          ),
        ),
      ),
    );
  }
}
