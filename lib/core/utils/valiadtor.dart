String? validateEmail(String ?value) {
  if ( value==null|| value.isEmpty) {
    return 'Please enter your email address';
  }
   if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}
String? checkEmpty(String ?value) {
  if (  value==null ||value.isEmpty) {
    return 'Please fill the field';
  }

  return null;
}
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  // Check for at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  }
  // Check for at least one lowercase letter
  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  }
  // Check for at least one digit
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one digit';
  }
  // Check for at least one special character
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }
  return null; // Return null if validation passes
}
