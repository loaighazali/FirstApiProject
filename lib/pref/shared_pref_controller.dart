import 'package:elancer_api/models/students.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { loggedIn, fullName, email, gender, token }

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();

  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Students students}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setString(
        PrefKeys.fullName.toString(), students.fullName);
    await _sharedPreferences.setString(
        PrefKeys.email.toString(), students.email);
    await _sharedPreferences.setString(
        PrefKeys.gender.toString(), students.gender);
    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ' + students.token);
  }

  bool get loggedIn => _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;

  String get token => _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  Future<bool> clear()async{
   return await _sharedPreferences.clear();
  }
}
