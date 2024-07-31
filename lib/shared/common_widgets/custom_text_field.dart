import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final bool? showPrefixIcon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? horizontalMargin;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Function()? onTap;
  final bool? isObsecure;
  final TextEditingController? controller;
  final bool? wantBorder;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? readOnly;
  final int? maxLength;
  final TextStyle? style;
  const CustomTextField(
      {super.key,
      this.hintStyle,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.style,
      this.readOnly,
      this.borderColor,
      this.wantBorder,
      this.onChanged,
      this.showPrefixIcon,
      this.width,
      this.focusNode,
      this.controller,
      this.isObsecure,
      this.maxLength,
      this.height,
      this.keyboardType,
      this.horizontalMargin});

  @override
  Widget build(BuildContext context) {
    final double marginHorizontal = horizontalMargin ?? context.width * 0.05;
    final double containerWidth = width ?? context.width;
    final double containerHeight = height ?? 60;

    return Container(
      height: containerHeight,
      width: containerWidth,
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      child: TextField(
        controller: controller,
        style: style,
        readOnly: readOnly ?? false,
        onTap: onTap,
        focusNode: focusNode,
        onChanged: (String value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        obscureText: isObsecure ?? false,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: _buildDecoration(context),
      ),
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    return showPrefixIcon == true
        ? _buildDecorationWithPrefixIcon(context)
        : _buildDefaultDecoration(context);
  }

  InputDecoration _buildDecorationWithPrefixIcon(BuildContext context) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      counterText: '',
      suffixIcon: suffixIcon ?? const SizedBox(),
      fillColor: Colors.white,
      filled: true,
      enabledBorder: _buildEnabledBorder(context),
      border: _buildBorder(),
      hintText: hintText ?? '',
      hintStyle: hintStyle,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    );
  }

  InputDecoration _buildDefaultDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      counterText: '',
      suffixIcon: suffixIcon ?? const SizedBox(),
      enabledBorder: _buildEnabledBorder(context),
      border: _buildBorder(),
      hintText: hintText ?? '',
      hintStyle: hintStyle ?? AppConsts.blackNormal15,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    );
  }

  OutlineInputBorder? _buildBorder() {
    return wantBorder == false ? null : const OutlineInputBorder();
  }

  OutlineInputBorder? _buildEnabledBorder(BuildContext context) {
    final Color borderColor = this.borderColor ?? Colors.grey;
    return wantBorder == false
        ? null
        : OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 0.0),
          );
  }
}
