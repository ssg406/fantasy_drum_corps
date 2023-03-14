import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferencesRepository(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  final registrationCompleteKey = 'registrationComplete';

  bool getRegistrationComplete() {
    return sharedPreferences.getBool(registrationCompleteKey) ?? false;
  }

  Future<void> setRegistrationComplete() async {
    await sharedPreferences.setBool(registrationCompleteKey, true);
  }

  Future<void> resetRegistrationStatus() async {
    await sharedPreferences.setBool(registrationCompleteKey, false);
  }
}

final sharedPreferencesRepositoryProvider =
    Provider<SharedPreferencesRepository>((_) => throw UnimplementedError());
