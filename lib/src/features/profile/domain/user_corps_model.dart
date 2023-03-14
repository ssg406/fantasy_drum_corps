class UserCorps {
  const UserCorps({required this.userId, required this.selectedCorps});
  final String userId;
  final String selectedCorps;

  factory UserCorps.fromMap(Map<String, dynamic> data) {
    return UserCorps(
      userId: data['userId'] as String,
      selectedCorps: data['selectedCorps'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'selectedCorps': selectedCorps,
    };
  }
}
