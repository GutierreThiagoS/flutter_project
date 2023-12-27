class ResponseUserLogin {
  String? userName;
  bool? authenticated;
  String? created;
  String? expiration;
  String? accessToken;
  String? refreshToken;

  ResponseUserLogin(
      {this.userName,
      this.authenticated,
      this.created,
      this.expiration,
      this.accessToken,
      this.refreshToken});

  ResponseUserLogin.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    authenticated = json['authenticated'];
    created = json['created'];
    expiration = json['expiration'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'authenticated': authenticated,
      'created': created,
      'expiration': expiration,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
