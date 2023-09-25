class InteriorThemeModel {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemImg;
  String? itemInfo;
  int? price;

  InteriorThemeModel(
      {this.itemId,
      this.itemName,
      this.itemType,
      this.itemImg,
      this.itemInfo,
      this.price});

  InteriorThemeModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemType = json['itemType'];
    itemImg = json['itemImg'];
    itemInfo = json['itemInfo'];
    price = json['price'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['itemId'] = itemId;
  //   data['itemName'] = itemName;
  //   data['itemType'] = itemType;
  //   data['itemImg'] = itemImg;
  //   data['itemInfo'] = itemInfo;
  //   data['price'] = price;
  //   return data;
  // }
}
