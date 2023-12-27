
import 'package:floor/floor.dart';
import 'package:flutter_project/domain/models/user_data.dart';

@dao
abstract class UserDataDao {

  @insert
  Future<void> insertUser(UserData user);

  @Query('SELECT * FROM UserData LIMIT 1')
  Future<UserData?> find();

  @Query('DELETE FROM UserData')
  Future<void> deleteAll();
}