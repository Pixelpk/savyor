class ServerResponse {
  String? msg;
  bool? error;
  dynamic code ;

  ServerResponse({this.msg, this.error,this.code});

  ServerResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    error = json['error'];
    if(json.containsKey("errorCode"))
      {
        code = json['errorCode'];
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['error'] = error;
    return data;
  }
}
