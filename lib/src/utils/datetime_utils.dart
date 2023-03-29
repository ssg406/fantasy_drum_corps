import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime dateTimeFromCombinedDateTime(DateTime full) =>
      DateTime(full.year, full.month, full.day);

  static TimeOfDay timeOfDayFromCombinedDateTime(DateTime full) =>
      TimeOfDay(hour: full.hour, minute: full.minute);

  static String formattedTime(TimeOfDay time, BuildContext context) =>
      time.format(context);

  static String formattedDate(DateTime date) =>
      DateFormat.yMMMMd('en_US').format(date);

  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) =>
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
}