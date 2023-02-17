class ScrapInstructionResponse {
  List<ScrappingInstruction> instruction = [];

  ScrapInstructionResponse.fromJson(Iterable data) {
    instruction = data.map((e) => ScrappingInstruction.fromJson(e)).toList();
  }
}

class ScrappingInstruction {
  int? id;
  String? diyId;
  String? diyIdScript;
  String? name;
  dynamic nameScript;
  String? websiteUrl;
  dynamic websiteUrlScript;
  String? titleScript;
  dynamic title;
  dynamic categoryOne;
  String? categoryOneScript;
  dynamic categoryTwo;
  String? categoryTwoScript;
  dynamic price;
  String? priceScript;
  dynamic quantity;
  String? quantityScript;
  String? productLink;
  String? productLinkScript;
  String? productPageLink;
  dynamic productPageLinkScript;
  String? searchPageLink;
  dynamic searchPageLinkScript;
  dynamic image;
  String? imageScript;
  String? color;
  dynamic colorScript;
  dynamic size;
  dynamic sizeScript;
  String? searchPageProducts;
  dynamic searchPageProductsScript;
  String? searchPageProductLink;
  dynamic searchPageProductLinkScript;
  String? createdAt;
  String? updatedAt;

  ScrappingInstruction(
      {this.id,
      this.diyId,
      this.diyIdScript,
      this.name,
      this.nameScript,
      this.websiteUrl,
      this.websiteUrlScript,
      this.titleScript,
      this.title,
      this.categoryOne,
      this.categoryOneScript,
      this.categoryTwo,
      this.categoryTwoScript,
      this.price,
      this.priceScript,
      this.quantity,
      this.quantityScript,
      this.productLink,
      this.productLinkScript,
      this.productPageLink,
      this.productPageLinkScript,
      this.searchPageLink,
      this.searchPageLinkScript,
      this.image,
      this.imageScript,
      this.color,
      this.colorScript,
      this.size,
      this.sizeScript,
      this.searchPageProducts,
      this.searchPageProductsScript,
      this.searchPageProductLink,
      this.searchPageProductLinkScript,
      this.createdAt,
      this.updatedAt});

  ScrappingInstruction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diyId = json['diy_id'];
    diyIdScript = json['diy_id_script'];
    name = json['name'];
    nameScript = json['name_script'];
    websiteUrl = json['website_url'];
    websiteUrlScript = json['website_url_script'];
    titleScript = json['title_script'];
    title = json['title'];
    categoryOne = json['category_one'];
    categoryOneScript = json['category_one_script'];
    categoryTwo = json['category_two'];
    categoryTwoScript = json['category_two_script'];
    price = json['price'];
    priceScript = json['price_script'];
    quantity = json['quantity'];
    quantityScript = json['quantity_script'];
    productLink = json['product_link'];
    productLinkScript = json['product_link_script'];
    productPageLink = json['product_page_link'];
    productPageLinkScript = json['product_page_link_script'];
    searchPageLink = json['search_page_link'];
    searchPageLinkScript = json['search_page_link_script'];
    image = json['image'];
    imageScript = json['image_script'];
    color = json['color'];
    colorScript = json['color_script'];
    size = json['size'];
    sizeScript = json['size_script'];
    searchPageProducts = json['search_page_products'];
    searchPageProductsScript = json['search_page_products_script'];
    searchPageProductLink = json['search_page_product_link'];
    searchPageProductLinkScript = json['search_page_product_link_script'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diy_id'] = diyId;
    data['diy_id_script'] = diyIdScript;
    data['name'] = name;
    data['name_script'] = nameScript;
    data['website_url'] = websiteUrl;
    data['website_url_script'] = websiteUrlScript;
    data['title_script'] = titleScript;
    data['title'] = title;
    data['category_one'] = categoryOne;
    data['category_one_script'] = categoryOneScript;
    data['category_two'] = categoryTwo;
    data['category_two_script'] = categoryTwoScript;
    data['price'] = price;
    data['price_script'] = priceScript;
    data['quantity'] = quantity;
    data['quantity_script'] = quantityScript;
    data['product_link'] = productLink;
    data['product_link_script'] = productLinkScript;
    data['product_page_link'] = productPageLink;
    data['product_page_link_script'] = productPageLinkScript;
    data['search_page_link'] = searchPageLink;
    data['search_page_link_script'] = searchPageLinkScript;
    data['image'] = image;
    data['image_script'] = imageScript;
    data['color'] = color;
    data['color_script'] = colorScript;
    data['size'] = size;
    data['size_script'] = sizeScript;
    data['search_page_products'] = searchPageProducts;
    data['search_page_products_script'] = searchPageProductsScript;
    data['search_page_product_link'] = searchPageProductLink;
    data['search_page_product_link_script'] = searchPageProductLinkScript;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
