
import 'package:floor/floor.dart';

@entity
class UserData {
  @primaryKey
  int id;
  String login;
  String password;
  String date;

  UserData(
      this.id,
      this.login,
      this.password,
      this.date
  );
}