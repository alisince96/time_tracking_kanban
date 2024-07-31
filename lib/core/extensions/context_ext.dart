// ignore_for_file: comment_references

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// This method will calculate dynamic height
  /// according to percentage of container height and
  /// total height of screen.
  /// Screen height is 844 in Zeplin
  /// So here it is given as default value
  /// If needed it can be changed be through referenceParentSize
  @Deprecated('Use dh extension on num instead')
  double hWRTPerctantage(num referenceChildSize,
      {num referenceParentSize = 844}) {
    return referenceChildSize / referenceParentSize * height;
  }

  /// This method will calculate dynamic width
  /// according to percentage of container width and
  /// total width of screen.
  double wWRTPerctantage(
    num referenceParentSize,
    num referenceChildSize,
  ) {
    return referenceChildSize / referenceParentSize * width;
  }

  /// This is a normal bottomsheet
  /// Backdrop Filter is added here we can remove from it everywhere else in the app
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

  /// This is a scroll bottomsheet
  /// Backdrop Filter is added here we can remove from it everywhere else in the app
  Future<void> showBottomSheetWithScroll({
    required Widget Function(BuildContext context) builder,
    String? title,
    bool? isScrollControlled,
    bool? enableDrag,
    bool? isDismissible,
    bool scrollUp = false,
    Color? bgColor,
    double borderRadius = 10,
  }) {
    return showModalBottomSheet(
      context: this,
      isDismissible: isDismissible ?? true,
      isScrollControlled: isScrollControlled ?? false,
      enableDrag: enableDrag ?? true,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        reverse: scrollUp,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: scrollUp ? MediaQuery.of(context).viewInsets.bottom : 0,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              // color: bgColor ?? AppColors.whiteColor,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(borderRadius)),
            ),
            child: builder.call(context),
          ),
        ),
      ),
    );
  }

  bool isSmallDevice() {
    return MediaQuery.sizeOf(this).height < 790;
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
