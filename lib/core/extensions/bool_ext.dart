extension BoolX on bool {
  String get toStringFromBool {
    final value = this;
    if (value) {
      return '1';
    } else {
      return '0';
    }
  }

  int get toIntFromBool {
    final value = this;
    if (value) {
      return 1;
    } else {
      return 0;
    }
  }

  bool get reverse {
    final value = this;
    return !value;
  }
}

extension BoolEXT on int {
  bool get toBoolFromInt {
    final value = this;
    if (value == 1) {
      return true;
    } else {
      return false;
    }
  }
}

extension BoolEX on String {
  bool get toBool {
    final value = this;
    if (value == '1') {
      return true;
    } else {
      return false;
    }
  }
}
