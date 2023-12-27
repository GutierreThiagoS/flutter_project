
class LoginResponse {

  String accessToken;
  String message;
  String status;

  LoginResponse(this.accessToken, this.message, this.status);

  factory LoginResponse.fromJson(Map json) {
    return LoginResponse(json['accessToken'] , json['message'], json['status']);
  }

  @override
  String toString() {
    return "accessToken: $accessToken, message: $message, status: $status";
  }
}