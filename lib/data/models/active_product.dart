import '../../application/network/external_values/iExternalValue.dart';
import '../../common/logger/log.dart';
import '../../di/di.dart';
import '../../ui/my_list/my_list_view_model.dart';

class ActiveProduct {
  Map<int, Product>? products;
  bool? error;
  String? msg;

  ActiveProduct({this.products, this.error, this.msg});

  ActiveProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      products = {};
      json['data'].forEach((v) {
        final parsed = Product.fromJson(v);
        products![parsed.iD!] = parsed;
      });
    }
    error = json['error'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['msg'] = msg;
    return data;
  }
}

class Product {
  int? iD;
  dynamic productID;
  dynamic productURL;
  dynamic modURL;
  dynamic shortURL;
  dynamic pictureURL;
  dynamic productName;
  dynamic rootCate;
  dynamic varColor;
  dynamic varSize;
  dynamic subCate;
  dynamic qty;
  dynamic currentPrice;
  dynamic trackActive;
  dynamic logInUsername;
  dynamic targetPrice;
  dynamic targetPeriod;
  dynamic latestPrice;
  dynamic priceDrop;
  double? price;
  int? period;
  dynamic status;
  dynamic isDeleted;
  dynamic timeStampUpdated;
  dynamic timeStamp;
  dynamic shipAddName;
  dynamic shipAddLine1;
  dynamic shipAddLine2;
  dynamic shipAddCity;
  dynamic shipAddZIP;
  dynamic shipAddState;
  bool? productActive;
  String? retailer;
  MyListViewModel? viewModel;
  late final IExternalValues externalValues = inject();

  Product(
      {this.iD,
      this.productID,
      this.productURL,
      this.modURL,
      this.shortURL,
      this.pictureURL,
      this.productActive = true,
      this.productName,
      this.rootCate,
      this.viewModel,
      this.varColor,
      this.varSize,
      this.retailer,
      this.subCate,
      this.qty,
      this.currentPrice,
      this.trackActive,
      this.logInUsername,
      this.targetPrice,
      this.targetPeriod,
      this.latestPrice,
      this.priceDrop,
      this.status,
      this.isDeleted,
      this.timeStampUpdated,
      this.timeStamp,
      this.shipAddName,
      this.shipAddLine1,
      this.shipAddLine2,
      this.shipAddCity,
      this.shipAddZIP,
      this.shipAddState});

  Product.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    productID = json['ProductID'];
    productURL = json['ProductURL'];
    modURL = json['ModURL'];
    shortURL = json['ShortURL'];
    pictureURL = "${externalValues.getBaseUrl()}${json['PictureURL']}";
    retailer = json['ProductURL'] == null
        ? "Name"
        : Uri.tryParse(json['ProductURL'])?.host.replaceAll(".com", '').replaceAll("www.", "");
    productName = json['ProductName'];
    rootCate = json['RootCate'];
    varColor = json['Var_Color'];
    varSize = json['Var_Size'];
    subCate = json['SubCate'];
    qty = json['Qty'];
    currentPrice = json['CurrentPrice'];
    if (currentPrice != null) {
      price = double.tryParse(currentPrice.toString()) ?? 0.0;
    }

    trackActive = json['TrackActive'];
    if (trackActive == "Y") {
      productActive = true;
    }
    if (trackActive == "N") {
      productActive = false;
    }
    logInUsername = json['LogIn_username'];
    targetPrice = json['TargetPrice'];
    targetPeriod = json['TargetPeriod'];
    if (targetPeriod != null) {
      period = int.tryParse(targetPeriod.toString()) ?? 0;
    }
    latestPrice = json['LatestPrice'];
    priceDrop = json['price_drop'];
    status = json['Status'];
    isDeleted = json['IsDeleted'];
    timeStampUpdated = json['TimeStamp_Updated'];
    timeStamp = json['TimeStamp'];
    shipAddName = json['ShipAdd_Name'];
    shipAddLine1 = json['ShipAdd_Line1'];
    shipAddLine2 = json['ShipAdd_Line2'];
    shipAddCity = json['ShipAdd_City'];
    shipAddZIP = json['ShipAdd_ZIP'];
    shipAddState = json['ShipAdd_State'];
  }

  String getRemainingDaysOrHours() {
    final pstCreation = timeStampUpdated ?? timeStamp;
    int trackPeriod = period ?? 0;
    if (pstCreation != null) {
      final currentDate = DateTime.now();
      final updatedTime = DateTime.tryParse(pstCreation)?.toLocal();
      if (updatedTime != null) {
        final parsed = updatedTime.add(Duration(days: int.tryParse(trackPeriod.toString()) ?? 0));
        trackPeriod = parsed.difference(currentDate).inDays;
        if (trackPeriod == 0) {
          trackPeriod = parsed.difference(currentDate).inHours;
          return "${trackPeriod.abs()} hours";
        }
        return "${trackPeriod.abs()} Days";
      }
    }

    return "0 Days";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['ProductID'] = productID;
    data['ProductURL'] = productURL;
    data['ModURL'] = modURL;
    data['ShortURL'] = shortURL;
    data['PictureURL'] = pictureURL;
    data['ProductName'] = productName;
    data['RootCate'] = rootCate;
    data['Var_Color'] = varColor;
    data['Var_Size'] = varSize;
    data['SubCate'] = subCate;
    data['Qty'] = qty;
    data['CurrentPrice'] = currentPrice;
    data['TrackActive'] = trackActive;
    data['LogIn_username'] = logInUsername;
    data['TargetPrice'] = targetPrice;
    data['TargetPeriod'] = targetPeriod;
    data['LatestPrice'] = latestPrice;
    data['price_drop'] = priceDrop;
    data['Status'] = status;
    data['IsDeleted'] = isDeleted;
    data['TimeStamp_Updated'] = timeStampUpdated;
    data['TimeStamp'] = timeStamp;
    data['ShipAdd_Name'] = shipAddName;
    data['ShipAdd_Line1'] = shipAddLine1;
    data['ShipAdd_Line2'] = shipAddLine2;
    data['ShipAdd_City'] = shipAddCity;
    data['ShipAdd_ZIP'] = shipAddZIP;
    data['ShipAdd_State'] = shipAddState;
    return data;
  }
}
