

class Utilityfunctions {

  static String format(String input) {
    // Remove all non-numeric characters
    final digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) return input; // Return as-is if not a 10-digit number

    // Format as (XXX) XXX-XXXX
    final areaCode = digits.substring(0, 3);
    final centralOfficeCode = digits.substring(3, 6);
    final lineNumber = digits.substring(6, 10);
    return '($areaCode) $centralOfficeCode-$lineNumber';
  }
  
}