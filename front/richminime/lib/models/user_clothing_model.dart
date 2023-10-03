class UserClothingModel {
  int? userClothingId;
  int? clothingId;
  String? clothingType;
  String? clothingImg;
  String? clothingApplyImg;
  String? clothingInfo;
  String? clothingName;
  int? price;
  int? balance;

  UserClothingModel(
      {this.userClothingId,
      this.clothingId,
      this.clothingType,
      this.clothingImg,
      this.clothingApplyImg,
      this.clothingInfo,
      this.clothingName,
      this.price,
      this.balance});

  UserClothingModel.fromJson(Map<String, dynamic> json) {
    userClothingId = json['userClothingId'];
    clothingId = json['clothingId'];
    clothingType = json['clothingType'];
    clothingImg = json['clothingImg'];
    clothingApplyImg = json['clothingApplyImg'];
    clothingInfo = json['clothingInfo'];
    clothingName = json['clothingName'];
    price = json['price'];
    balance = json['balance'];
  }
}
