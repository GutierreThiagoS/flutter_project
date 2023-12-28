
import 'package:floor/floor.dart';

@entity
class UserData {
  @primaryKey
  int id;
  String login;
  String password;
  String date;
  String expiration;
  String accessToken;
  String refreshToken;

  UserData(
      this.id,
      this.login,
      this.password,
      this.date,
      this.expiration,
      this.accessToken,
      this.refreshToken
  );
}