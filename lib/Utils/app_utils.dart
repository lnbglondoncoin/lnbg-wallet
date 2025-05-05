import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('MMM dd, hh:mm a').format(dateTime);
}

String shortenAddress(String address) {
  if (address.length <= 10) return address;
  String start = address.substring(0, 8); // First 8 characters
  String end = address.substring(address.length - 9); // Last 9 characters
  return '$start...$end';
}

