extension DurationX on Duration {
  // This method formats the Duration object into a human-readable string.
  // It checks if the Duration is more than a day, if it is, it converts the
  // Duration to hours and minutes and formats it into a string. If the Duration
  // is less than a day, it directly formats it into hours and minutes.
  String format() {
    // This function formats a number into a string with a leading zero if it's
    // less than 10.
    String formatTwoDigits(int number) => number.toString().padLeft(2, '0');

    // This function formats the Duration into a string with hours and minutes.
    String formatHours(Duration duration) {
      // Get the number of hours in the Duration, and modulo 24 to get the
      // actual hours.
      int hours = duration.inHours % 24;

      // Get the number of minutes in the Duration.
      int minutes = duration.inMinutes.remainder(60);

      // Format the hours and minutes into a string with a leading zero if needed.
      return '${formatTwoDigits(hours)}:${formatTwoDigits(minutes)} hrs';
    }

    // If the Duration is more than a day, format it into days and hours and
    // minutes.
    if (inDays > 0) {
      return '$inDays days ${formatHours(this)}';
    }
    // If the Duration is less than a day but more than an hour, format it into
    // hours and minutes.
    else if (inHours > 0) {
      return formatHours(this);
    }
    // If the Duration is less than an hour, format it into minutes.
    else {
      return '$inMinutes minutes';
    }
  }
}
