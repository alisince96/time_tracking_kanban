import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/data/models/comment_response.dart';
import 'package:time_tracking_app/presentation/screens/task_details/task_details_cubit.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/common_widgets/custom_text_field.dart';

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({
    super.key,
    required this.commentController,
    required this.id,
  });
  final TextEditingController commentController;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Comment',
            style: AppConsts.blackNormal25
                .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          controller: commentController,
          hintText: 'Comment',
          horizontalMargin: 0,
          hintStyle: TextStyle(
              color: AppConsts.greyish.withOpacity(0.5), fontSize: 14),
          borderColor: Colors.transparent,
          suffixIcon: GestureDetector(
            onTap: () {
              final params = Comment(
                  content: commentController.text,
                  taskId: id,
                  postedAt: DateTime.now());
              context.read<TaskDetailsCubit>().addComment(params);
            },
            child: Icon(Icons.send,
                color: commentController.text.isNotEmpty
                    ? AppConsts.darkBlue
                    : AppConsts.greyish),
          ),
        ),
      ],
    );
  }
}
