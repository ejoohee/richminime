class RoomItemModel {
  int? itemId;
  String? itemType;
  String? itemImg;

  RoomItemModel({this.itemId, this.itemType, this.itemImg});

  RoomItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    itemImg = json['itemImg'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['itemId'] = itemId;
  //   data['itemType'] = itemType;
  //   data['itemURL'] = itemURL;
  //   return data;
  // }
}
