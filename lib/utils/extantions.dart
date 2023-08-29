import 'package:flutter/material.dart';

Size size(BuildContext context) => MediaQuery.of(context).size;

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget youngster, AxisDirection axisDirection) {
    return youngster;
  }
}

extension StringHtmlExtensions on String {
  String removeHtmlTags() {
    // Define a regular expression pattern to match HTML tags
    final RegExp htmlTagsRegex = RegExp(r'<[^>]*>');

    // Use the replaceAll method to remove HTML tags from the string
    return this.replaceAll(htmlTagsRegex, '');
  }
}

extension DateTimeExtensions on DateTime {
  String timePassedFromNow() {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(this);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} сония аввал";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} дақиқа аввал";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} соат аввал";
    } else {
      int days = difference.inDays;
      return days == 1 ? "1 кун аввал" : "$days кун аввал";
    }
  }
}

extension SpecialSymbolsExtension on String {
  String replaceSpecialSymbols() {
    String output = this;
    output = output.replaceAll('&quot;', '"');
    output = output.replaceAll('&nbsp;', '\u00A0');
    // Add more replacements as needed
    return output;
  }
}

extension HexColor on String {
  Color toColor() {
    // Remove the '#' symbol if present
    String hexColor = this.replaceAll("#", "");

    // Convert the hexadecimal string to an integer
    int colorValue = int.parse(hexColor, radix: 16);

    // Create a Color object from the integer value
    return Color(colorValue);
  }
}

extension TimestampExtensions on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}
