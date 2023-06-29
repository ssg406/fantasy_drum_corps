import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef Validator = String? Function(String?);

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key? key,
    required this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.onSelectedDate,
    this.onSelectedTime,
    this.dateTimeErrorText,
  }) : super(key: key);

  final String labelText;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final ValueChanged<DateTime>? onSelectedDate;
  final ValueChanged<TimeOfDay>? onSelectedTime;
  final String? dateTimeErrorText;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023, 9, 15),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate?.call(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectedTime?.call(pickedTime);
    }
  }

  String _getFormattedDate() =>
      selectedDate == null ? '' : DateFormat.yMMMd().format(selectedDate!);

  String _getFormattedTime(BuildContext context) =>
      selectedTime == null ? '' : selectedTime!.format(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        gapH32,
        TextFormField(
          controller: TextEditingController()..text = _getFormattedDate(),
          validator: (input) =>
              input == null || input.isEmpty ? 'Please enter a date' : null,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today_rounded),
            labelText: 'Select Date',
            errorText: dateTimeErrorText,
          ),
          onTap: () => _selectDate(context),
        ),
        gapH32,
        TextFormField(
          controller: TextEditingController()
            ..text = _getFormattedTime(context),
          validator: (input) =>
              input == null || input.isEmpty ? 'Please enter a time' : null,
          decoration: InputDecoration(
              icon: const Icon(Icons.access_time_rounded),
              labelText: 'Select Time',
              errorText: dateTimeErrorText),
          onTap: () => _selectTime(context),
        )
      ],
    );
  }
}
