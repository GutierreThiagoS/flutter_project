
import 'package:flutter/foundation.dart';
import 'package:flutter_project/domain/models/user_data.dart';
import 'package:flutter_project/domain/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {

  final UserRepository _userRepository;
  LoginController(this._userRepository);

  ValueNotifier<bool> inLoading = ValueNotifier(false);

  String _login = 'gutierre';
  setLogin(String value) => _login = value;

  String _pass = 'admin123';
  setPass(String value) => _pass = value;

  Future<bool> singIn() async {
    inLoading.value = true;
    Future.delayed(const Duration(seconds: 2));

    var result = await _userRepository.asyncLogin(_login, _pass);
    inLoading.value = false;
    return result;
  }

  Future<bool> isLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      var user = prefs.getString('user');
      var pass = prefs.getString('pass');
      return user != null && pass != null;
    } else {
      UserData? result = await _userRepository.find();
      return result != null;
    }
  }

}