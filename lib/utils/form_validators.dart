
class FormValidators {
  static String? mobileNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the mobile number';
    }

    /// Check if the mobile number is less than 10 digits
    if (value.length < 10) {
      return 'Please enter a valid mobile number with at least 10 digits';
    }

    return null;
  }
}

