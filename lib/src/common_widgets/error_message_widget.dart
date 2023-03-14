import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {Key? key}) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 400,
      height: 300,
      child: Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.errorContainer,
        child: Center(
          child: Text(errorMessage,
              style: theme.textTheme.titleLarge!
                  .copyWith(color: theme.colorScheme.onErrorContainer)),
        ),
      ),
    );
  }
}
