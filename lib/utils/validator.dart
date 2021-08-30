class Validator {
  static bool isPhoneNovalid(String? phoneNo) {
    if (phoneNo == null) return false;
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(phoneNo);
  }

  // static String isIdentityValid(String? id) {
  //   String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (id!.length == 0) {
  //     return 'Please enter mobile number';
  //   } else if (!regExp.hasMatch(id)) {
  //     return 'Please enter valid mobile number';
  //   }
  // }
}
