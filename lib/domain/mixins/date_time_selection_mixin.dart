import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

mixin DateTimePickerMixin {
  // This function is used to show a custom date time picker dialog to the user.
  // It takes in several parameters:
  // - context: the BuildContext of the widget that is calling this function.
  // - initialDate: the initial date that the picker will display.
  // - minimumDate: the earliest date that the user can select.
  // - maximumDate: the latest date that the user can select.
  // - onChanged: a callback function that will be called whenever the user selects a new date.
  // - onConfirm: a callback function that will be called when the user confirms their selection.
  // The function returns a Future<DateTime?> that will eventually resolve to the selected date,
  // or null if the user cancels the dialog.
  Future<DateTime?> showCustomDateTimePicker(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime minimumDate,
    required DateTime maximumDate,
    Function(DateTime)? onChanged,
    Function(DateTime)? onConfirm,
  }) async {
    // Show the date time picker dialog to the user.
    // The dialog will display the initial date and time, and allow the user to select a new date and time within the specified range.
    final selectedDate = await DatePicker.showDateTimePicker(
      context, // The BuildContext of the widget that is calling this function.
      showTitleActions:
          true, // Whether to show the title actions (e.g. 'Done' and 'Cancel' buttons).
      minTime: minimumDate, // The earliest date that the user can select.
      maxTime: maximumDate, // The latest date that the user can select.
      onChanged: (date) {
        // Call the onChanged callback function with the new date that the user has selected.
        onChanged?.call(date);
      },
      onConfirm: (date) {
        // Call the onConfirm callback function with the new date that the user has selected.
        onConfirm?.call(date);
      },
      currentTime:
          DateTime.now(), // The current date and time to display in the dialog.
    );

    // If the user has selected a date, call the onChanged callback function with the selected date,
    // and return the selected date.
    if (selectedDate != null) {
      onChanged?.call(selectedDate);
      return onConfirm?.call(selectedDate) ?? selectedDate;
    }

    // If the user has not selected a date, return null.
    return null;
  }
}
