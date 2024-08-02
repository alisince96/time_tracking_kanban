import 'package:flutter/material.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';

class AllCommentsList extends StatelessWidget {
  const AllCommentsList({super.key, required this.comments});
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: AppConsts.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(comments[index].content ?? '',
                        style: AppConsts.blackNormal25.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                            comments[index]
                                    .postedAt
                                    ?.toIso8601String()
                                    .split('T')
                                    .first ??
                                '',
                            style: AppConsts.greyNormal15.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: comments.length);
  }
}
