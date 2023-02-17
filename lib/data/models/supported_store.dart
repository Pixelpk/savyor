class SupportedStore {
  String? msg;
  bool? error;
  List<Store>? stores;

  SupportedStore({this.msg, this.error, this.stores});

  SupportedStore.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    error = json['error'];
    if (json['data'] != null) {
      stores = <Store>[];
      json['data'].forEach((v) {
        stores!.add(Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['error'] = error;
    if (stores != null) {
      data['data'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  String? name;
  String? url;
  String? logo;

  Store({this.name, this.url, this.logo});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['logo'] = logo;
    return data;
  }
}
