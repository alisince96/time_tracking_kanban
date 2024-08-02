import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 25,
      child: Container(
        height: 80,
        color: AppConsts.appGrey,
        width: context.width,
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppConsts.greyish.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: GestureDetector(
                  onTap: () => context.pop(), child: const Icon(Icons.close)),
            ),
          ],
        ),
      ),
    );
  }
}
