/// Format Numbers with commas
class Format {
  /// Formats Integer with Commas [toCurrency]
  static String toCurrency(int numberToFormat) {
    final String numberFormatted = numberToFormat
        .toString()
        .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return '\$$numberFormatted';
  }
}
