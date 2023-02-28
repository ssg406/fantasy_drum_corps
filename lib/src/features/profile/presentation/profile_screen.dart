import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Profile screen used to view and adjust user details
class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'User Profile',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
