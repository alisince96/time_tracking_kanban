extension NullAbleString on String? {
  /// Check if string is empty or null
  bool get isEmptyOrNull {
    return this?.isEmpty ?? true;
  }

  /// Check if string is not empty or not null
  bool get isNotEmptyOrNull {
    return this?.isNotEmpty ?? false;
  }
}
