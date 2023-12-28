
import 'package:flutter_project/data/remote/state/state_info.dart';
import 'package:flutter_project/domain/models/user_data.dart';

abstract class UserRepository {

  Future<bool> insert(UserData user);

  Future<UserData?> find();

  Future<bool> deleteAll();

  Future<bool> asyncLogin(String login, String password);

  Future<StateInfo> asyncRegisterUser(
      String fullName,
      String email,
      String userName,
      String password
  );
}