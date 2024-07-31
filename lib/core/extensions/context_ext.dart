// ignore_for_file: comment_references

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Future<void> showBottomSheet({
    required Widget Function(BuildContext context) builder,
    String? title,
    bool? isScrollControlled,
    bool? enableDrag,
    bool? isDismissible,
    bool scrollUp = false,
    double borderRadius = 10,
    Color? color,
    EdgeInsetsGeometry? padding,
    double? height,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      isDismissible: isDismissible ?? false,
      isScrollControlled: isScrollControlled ?? false,
      enableDrag: enableDrag ?? true,
      constraints: BoxConstraints(maxHeight: this.height * 0.92),
      backgroundColor: color ?? Colors.transparent,
      barrierColor: barrierColor,
      builder: (context) => Container(
        height: height,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadius)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: scrollUp ? MediaQuery.of(context).viewInsets.bottom : 0,
          ),
          child: builder.call(context),
        ),
      ),
    );
  }

  double get width {
    return MediaQuery.sizeOf(this).width;
  }

  double get height {
    return MediaQuery.sizeOf(this).height;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
