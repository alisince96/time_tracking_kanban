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
    return Container(
      height: height ?? 60,
      width: width ?? context.width,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin ?? context.width * 0.05),
      child: TextField(
        controller: controller,
        style: style,
        readOnly: readOnly ?? false,
        onTap: onTap,
        focusNode: focusNode,
        onChanged: (var value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        obscureText: isObsecure ?? false,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: showPrefixIcon == true
            ? InputDecoration(
                prefixIcon: prefixIcon,
                counterText: '',
                suffixIcon: suffixIcon ?? const SizedBox(),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: wantBorder == false
                    ? null
                    : OutlineInputBorder(
                        borderSide: BorderSide(
                            color: borderColor ?? Colors.grey, width: 0.0),
                      ),
                border: wantBorder == false ? null : const OutlineInputBorder(),
                hintText: hintText ?? '',
                hintStyle: hintStyle,
                contentPadding:
                    const EdgeInsets.only(left: 15.0, top: 5.0, right: 15),
              )
            : InputDecoration(
                fillColor: Colors.white,
                filled: true,
                counterText: '',
                suffixIcon: suffixIcon ?? const SizedBox(),
                enabledBorder: wantBorder == false
                    ? null
                    : OutlineInputBorder(
                        borderSide: BorderSide(
                            color: borderColor ?? Colors.grey, width: 0.0),
                      ),
                border: wantBorder == false ? null : const OutlineInputBorder(),
                hintText: hintText ?? '',
                hintStyle: hintStyle ?? AppConsts.greenNormal15,
                contentPadding:
                    const EdgeInsets.only(left: 15.0, top: 5.0, right: 15),
              ),
      ),
    );
  }
}
