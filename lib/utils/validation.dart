class Validators {
  static String? emailValidation(String? text) {
    if (text == null || text == '') {
      return 'Enter valid Email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(text)) {
      return 'Enter valid Email';
    }
    return null;
  }

  static String? passwordValidation(String? text) {
    if (text == '' || text == null) {
      return 'Enter valid password';
    }

    if (text.length < 6) {
      return 'Enter a strong password';
    }

    return null;
  }

  static String? nameValidation(String? text) {
    if (text == '' || text == null) {
      return 'Enter valid name';
    }

    if (text.length < 4) {
      return 'Enter atleast 4 characters';
    }

    return null;
  }

  static String? bioValidation(String? text) {
    if (text == '' || text == null) {
      return 'Enter valid name';
    }

    if (text.length < 4) {
      return 'Enter atleast 4 characters';
    }

    return null;
  }
}
