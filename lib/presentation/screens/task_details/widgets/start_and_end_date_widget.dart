import 'package:flutter/material.dart';
import 'package:time_tracking_app/domain/mixins/date_time_selection_mixin.dart';
import 'package:time_tracking_app/shared/app_consts/app_consts.dart';
import 'package:time_tracking_app/shared/common_widgets/custom_text_field.dart';

class StartAndEndDateWidget extends StatelessWidget with DateTimePickerMixin {
  const StartAndEndDateWidget(
      {super.key,
      required this.startDateController,
      required this.endDateController,
      required this.startDate,
      required this.endDate});
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final void Function(DateTime?) startDate;
  final void Function(DateTime?) endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start Time',
            style: AppConsts.blackNormal25
                .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          controller: startDateController,
          hintText: '2 Aug 5:00 PM',
          readOnly: true,
          onTap: () {
            showCustomDateTimePicker(
              context,
              minimumDate: DateTime.now().subtract(const Duration(days: 365)),
              maximumDate: DateTime.now().add(const Duration(days: 365)),
              onConfirm: (date) {
                startDate(date);
                startDateController.text = date.toString();
              },
              initialDate: DateTime.now(),
            );
          },
          hintStyle: TextStyle(
              color: AppConsts.greyish.withOpacity(0.5), fontSize: 14),
          horizontalMargin: 0,
          borderColor: Colors.transparent,
        ),
        const SizedBox(
          height: 15,
        ),
        Text('End Time',
            style: AppConsts.blackNormal25
                .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          controller: endDateController,
          hintText: '3 Aug 5:00 PM',
          readOnly: true,
          onTap: () {
            showCustomDateTimePicker(
              context,
              minimumDate: DateTime(2023, 3, 5),
              maximumDate: DateTime.now().add(const Duration(days: 365)),
              onConfirm: (date) {
                endDate(date);
                endDateController.text = date.toString();
              },
              initialDate: DateTime.now(),
            );
          },
          hintStyle: TextStyle(
              color: AppConsts.greyish.withOpacity(0.5), fontSize: 14),
          horizontalMargin: 0,
          borderColor: Colors.transparent,
        ),
      ],
    );
  }
}
