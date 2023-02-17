class TrackProductEntity {
  String? userName;
  String? auth;
  String? productLink;
  String? targetPrice;
  String? targetPeriod;
  Map<String, dynamic>? instruction;

  TrackProductEntity(
      {this.userName, this.auth, this.productLink, this.targetPrice, this.targetPeriod, this.instruction});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["token"] = auth;
    data["productLink"] = productLink;
    data["targetPeriod"] = targetPeriod;
    data["targetPrice"] = targetPrice;
    data["userEmail"] = userName;
    data["s_data"] = instruction;
    return data;
  }
}
