class UpdateProductEntity {
  String? productLink;
  String? targetPrice;
  String? targetPeriod;
  final bool? productActive;
  dynamic productId;

  UpdateProductEntity({this.productLink, this.targetPrice, this.targetPeriod, this.productId, this.productActive});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_url"] = productLink;
    if (productActive == null) {
      data["target_period"] = targetPeriod;
      data["target_price"] = targetPrice;
    }
    if (productActive != null && productActive!) {
      data["product_url"] = productLink;
      data["track_active"] = "N";
    }
    if (productActive != null && !productActive!) {
      data["product_url"] = productLink;
      data["track_active"] = "Y";
    }
    return data;
  }
}
