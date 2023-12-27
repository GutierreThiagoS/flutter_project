
class LoginRequest {
  String username;
  String password;
  String domaing;

  LoginRequest(this.username, this.password, this.domaing);

  String stringifier() {
    return "{ username: $username, password: $password, domaing: $domaing }";
  }
}