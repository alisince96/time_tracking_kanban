import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/extensions/context_ext.dart';
import 'package:time_tracking_app/core/extensions/date_time_ext.dart';
import 'package:time_tracking_app/core/extensions/string_ext.dart';
import 'package:time_tracking_app/data/models/task_response.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/images_path/images_path.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, this.padding, this.onTap, required this.task});
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final TaskResponse task;

  int get comments => task.commentCount ?? 0;
  bool get showComments => comments > 0;
  String get content => task.content ?? '';
  String get description => task.description ?? '';
  Duration? get timeSpent => task.timeSpent;
  String get createdAt =>
      task.createdAt?.toIso8601String().split('T').first ?? '';
  String get startTime => task.startTime?.toString().split('.').first ?? '';
  String get endTime => task.endTime?.toString().split('.').first ?? '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Container(
          width: context.width,
          decoration: BoxDecoration(
            color: AppConsts.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: AppConsts.blackBold.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppConsts.black),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: AppConsts.blackNormal15.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppConsts.greyish),
                  ),
                  const SizedBox(height: 20),
                ],
                if (timeSpent != null) ...[
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: AppConsts.darkBlue),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        'Time spent: ${timeSpent?.format()}',
                        style: AppConsts.blackNormal15.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppConsts.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                if (createdAt.isNotEmptyOrNull) ...[
                  Row(
                    children: [
                      Text(
                        'created at:',
                        style: AppConsts.greyishNormal.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        createdAt,
                        style: AppConsts.greyishNormal.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
                if (startTime.isNotEmptyOrNull) ...[
                  Row(
                    children: [
                      Text(
                        'started at:',
                        style: AppConsts.greyishNormal.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        startTime,
                        style: AppConsts.greyishNormal.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
                if (endTime.isNotEmptyOrNull) ...[
                  Row(
                    children: [
                      Text(
                        'completed at:',
                        style: AppConsts.greyishNormal.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        endTime,
                        style: AppConsts.greyishNormal.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
                if (showComments) ...[
                  Row(
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Image.asset(
                              ImagesPath.chat,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              comments.toString(),
                              style: AppConsts.blackBold.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
