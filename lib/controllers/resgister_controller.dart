
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/data/remote/state/state_info.dart';
import 'package:flutter_project/domain/repository/user_repository.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final RegExp regExpEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class RegisterController extends ChangeNotifier {

  final UserRepository _userRepository;
  RegisterController(this._userRepository);

  ValueNotifier<String> userName = ValueNotifier<String>("");
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  String _fullName = '';
  setFullName(String value) => _fullName = value;

  String _email = '';
  setEmail(String value) => _email = value;

  setUserName(String value) {
    userName.value = value.replaceAll(" ", "_").toLowerCase();
  }

  String _password = '';
  setPassword(String value) => _password = value;

  Future<StateInfo> registerUser() async {
    if(regExpEmailValid.hasMatch(_email)) {
      loading.value = true;
      StateInfo state = await _userRepository.asyncRegisterUser(_fullName, _email, userName.value, _password);
      loading.value = false;
      return state;
    } else {
      return StateInfo(false, "Email inválido!");
    }
  }
  //{"userName":"gutim","fullName":"Gutierre Thiago ","email":"guti","password":"123456789","platform":"flutter"}
}

final registerUser = FutureProvider<StateInfo>((ref) async {
  return ref.watch(injectRegisterController).registerUser();
});