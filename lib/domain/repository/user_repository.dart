
import 'package:flutter_project/domain/models/user_data.dart';

abstract class UserRepository {

  Future<bool> insert(UserData user);

  Future<UserData?> find();

  Future<bool> deleteAll();

  Future<bool> asyncLogin(UserData user);
}