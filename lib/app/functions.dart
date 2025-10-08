bool isPhoneValid(String phone) => phone.isNotEmpty;

bool isPasswordValid(String password) => password.isNotEmpty;

// bool isPhoneValid(String phone) {
//   // Iraqi phone: starts with 07 + 9 digits (total 11 digits)
//   final phoneRegex = RegExp(r'^07[0-9]{9}$');
//   return phoneRegex.hasMatch(phone.trim());
// }

// bool isPasswordValid(String password) {
//   // Strong password: min 8 chars, 1 uppercase, 1 lowercase, 1 digit, 1 special char
//   final passwordRegex =
//   RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   return passwordRegex.hasMatch(password);
// }

// bool userNameValid(String userName) {
//   // At least 3 characters, letters, numbers, underscores
//   final nameRegex = RegExp(r'^[a-zA-Z0-9_]{3,}$');
//   return nameRegex.hasMatch(userName.trim());
// }

// bool isNotEmpty(String value) {
//   return value.trim().isNotEmpty;
// }

