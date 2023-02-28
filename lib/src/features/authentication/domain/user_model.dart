typedef UserID = String;

class FdcUser {
  const FdcUser(
      {required this.uid,
      required this.email,
      required this.displayName,
      required this.sponsoredCorps,
      this.userAvatar});
  final UserID uid;
  final String email;
  final String displayName;
  final String sponsoredCorps;
  final String? userAvatar;
  String get name => displayName;
  UserID get id => uid;

  factory FdcUser.fromMap(Map<dynamic, dynamic> data, UserID id) {
    return FdcUser(
      uid: id,
      email: data['email'] as String,
      displayName: data['displayName'] as String,
      sponsoredCorps: data['sponsoredCorps'] as String,
      userAvatar: data['userAvatar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': uid,
      'email': email,
      'displayName': displayName,
      'sponsoredCorps': sponsoredCorps,
      'userAvatar': userAvatar,
    };
  }
}
