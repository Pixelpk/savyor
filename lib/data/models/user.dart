class User {
  String? msg;
  bool? error;
  String? username;
  String? token;
  String? imageUrl;
  bool? auth;

  User({this.msg, this.error, this.username, this.token, this.auth,this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    error = json['error'];
    if(json.containsKey("username")) {
      username = json['username'];
    }
    token = json['token'];
    auth = json['auth'];
    if(json.containsKey("image"))
      {
        imageUrl = json['image'] ;
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['error'] = error;
    data['username'] = username;
    data['token'] = token;
    data['auth'] = auth;
    data['image']=imageUrl ;
    return data;
  }
}
