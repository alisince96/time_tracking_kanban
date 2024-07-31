extension NullAbleString on String? {
  String? safeSubString(int start, [int? end]) {
    try {
      return this?.substring(start, end);
    } catch (e) {
      return this;
    }
  }

  bool equals(String value) {
    return this?.toLowerCase() == value.toLowerCase();
  }

  bool doesnotEqual(String value) {
    return this?.toLowerCase() != value.toLowerCase();
  }

  /// Check if string is empty or null
  bool get isEmptyOrNull {
    return this?.isEmpty ?? true;
  }

  /// Check if string is not empty or not null
  bool get isNotEmptyOrNull {
    return this?.isNotEmpty ?? false;
  }
}

extension StringX on String {
  DateTime convertToDateTime() {
    try {
      if (isEmpty) {
        return DateTime.now();
      } else {
        return DateTime.tryParse(this) ?? DateTime.now();
      }
    } catch (e) {
      return DateTime.now();
    }
  }
}
