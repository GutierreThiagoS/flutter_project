class ResponseInfo {
  String info;
  bool status;

  ResponseInfo(this.info, this.status);

  factory ResponseInfo.fromJson(Map json) {
    return ResponseInfo(json['info'] , json['status']);
  }

  @override
  String toString() {
    return "info: $info, status: $status";
  }
}