import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class RoundButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final double? horizontalMargin;
  final Color? buttonColor;
  final double? borderRadius;
  final double? borderWidth;
  final Gradient? gradient;

  final double? letterSpacing;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool? showDoubleLineText;
  final String? firstLineText;
  final String? secondLineText;
  const RoundButton(
      {super.key,
      this.text,
      this.onPressed,
      this.horizontalMargin,
      this.buttonHeight,
      this.buttonWidth,
      this.firstLineText,
      this.secondLineText,
      this.letterSpacing,
      this.showDoubleLineText,
      this.borderColor,
      this.buttonColor,
      this.textStyle,
      this.borderWidth,
      this.gradient,
      this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        height: buttonHeight ?? 55,
        width: buttonWidth ?? context.width,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          color: buttonColor ?? AppConsts.splashColor,
          gradient: gradient,
        ),
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (showDoubleLineText == true) {
      return _buildDoubleLineText(context);
    } else {
      return _buildSingleLineText(context);
    }
  }

  Widget _buildDoubleLineText(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildText(firstLineText!, FontWeight.w800),
          _buildText(secondLineText!, FontWeight.normal),
        ],
      ),
    );
  }

  Widget _buildSingleLineText(BuildContext context) {
    return Center(
      child: _buildText(text, FontWeight.w800),
    );
  }

  Widget _buildText(String? text, FontWeight fontWeight) {
    return Text(
      text ?? '',
      style: textStyle ??
          TextStyle(
            color: Colors.black,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            fontFamily: 'Helvetica',
          ),
    );
  }
}
