class JwtTokensModel {
  TokenItem? access;
  TokenItem? refresh;

  JwtTokensModel({this.access, this.refresh});

  JwtTokensModel.fromJson(Map<String, dynamic> json) {
    access = json['access'] != null ? TokenItem.fromJson(json['access']) : null;
    refresh = json['refresh'] != null ? TokenItem.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (access != null) {
      data['access'] = access!.toJson();
    }
    if (refresh != null) {
      data['refresh'] = refresh!.toJson();
    }
    return data;
  }
}

class TokenItem {
  String? token;
  String? expires;

  TokenItem({this.token, this.expires});

  TokenItem.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['expires'] = expires;
    return data;
  }
}
