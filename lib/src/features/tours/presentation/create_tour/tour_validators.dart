import 'package:intl/intl.dart';

/// Collection of validator functions for [CreateTour] widget
mixin TourValidators {
  final latestDraftDate = DateTime(2023, 6, 13);

  String get formattedLastDraftDate =>
      DateFormat.yMMMMd('en_US').format(latestDraftDate);

  bool canSubmitName(String name) {
    // Allow 4-30 alphanumeric characters
    final RegExp nameExp = RegExp(r'^[a-zA-Z\d\s]{4,30}$');
    return _testRegExp(nameExp, name);
  }

  bool canSubmitDescription(String description) {
    // Allow 4-75 alphanumeric characters
    final RegExp descExp = RegExp(r'^[a-zA-Z\d\s]{4,75}$');
    return _testRegExp(descExp, description);
  }

  bool canSubmitTourPassword(String password) {
    // Allow between 4 and 10 alphanumeric characters
    final RegExp passwordExp = RegExp(r'^[a-zA-Z\d]{4,10}$');
    return _testRegExp(passwordExp, password);
  }

  bool _testRegExp(RegExp regExp, String input) {
    RegExpMatch? matchedInput = regExp.firstMatch(input);
    return matchedInput?[0] != null;
  }

  String? getNameErrors(String name) {
    final bool showNameErrors = !canSubmitName(name);
    final String nameError = name.isEmpty
        ? 'Please enter a tour name'
        : 'Please make sure the name has between 4-30 letters and numbers only';
    return showNameErrors ? nameError : null;
  }

  String? getDescriptionErrors(String description) {
    final bool showDescriptionErrors = !canSubmitDescription(description);
    final String descriptionError = description.isEmpty
        ? 'Please enter a description'
        : 'Please make sure the description has 4-75 letters and numbers only.';
    return showDescriptionErrors ? descriptionError : null;
  }

  String? getPasswordErrors(String password) {
    final bool showPasswordErrors = !canSubmitTourPassword(password);
    final String passwordError = password.isEmpty
        ? 'Please enter a password for private tours'
        : 'Please make sure the password is between 4-10 letters and numbers with no spaces';
    return showPasswordErrors ? passwordError : null;
  }

  String? getDateErrors(String date) {
    return date.isEmpty ? 'Please enter a date' : null;
  }
}
