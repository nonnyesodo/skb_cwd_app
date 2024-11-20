class AuthValidator {
  static String? validatePassword(String value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*.~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 6) {
      return 'Password must be more than 6';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must contain uppercase,Special character and digit';
      } else {
        return null;
      }
    }
  }

  static String? validateAnyField(
      {required String field, required String value}) {
    if (value.isEmpty) {
      return '$field field is required ';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber({value}) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }

    final pattern = RegExp(r'^\+?[0-9]{8,}$');

    if (!pattern.hasMatch(value)) {
      return 'Invalid phone number';
    } else if (value.length < 11) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Please enter Email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid email';
      } else {
        return null;
      }
    }
  }

  static String? validateName(String value) {
    if (value.length < 3) {
      return 'Min name length 3';
    } else {
      return null;
    }
  }

  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return 'Please enter mobile Number';
    } else if (value.length < 11) {
      return 'Min mobile number 11';
    } else if (value.length > 11) {
      return 'Max mobile number 11';
    } else {
      return null;
    }
  }
}
