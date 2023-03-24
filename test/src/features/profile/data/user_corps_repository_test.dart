import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/profile/data/user_corps_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('queryUserCorps returns UserCorps Query object', () {
    final userCorpsRepository = UserCorpsRepository(FirebaseFirestore.instance);
  });
}
