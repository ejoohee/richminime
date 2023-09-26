class ClothingModel {
  int? clothingId;
  String? clothingType;
  String? clothingImg;
  String? clothingApplyImg;
  String? clothingInfo;
  String? clothingName;
  int? price;

  ClothingModel(
      {this.clothingId,
      this.clothingType,
      this.clothingImg,
      this.clothingApplyImg,
      this.clothingInfo,
      this.clothingName,
      this.price});

  ClothingModel.fromJson(Map<String, dynamic> json) {
    clothingId = json['clothingId'];
    clothingType = json['clothingType'];
    clothingImg = json['clothingImg'];
    clothingApplyImg = json['clothingApplyImg'];
    clothingInfo = json['clothingInfo'];
    clothingName = json['clothingName'];
    price = json['price'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['clothingId'] = this.clothingId;
  //   data['clothingType'] = this.clothingType;
  //   data['clothingImg'] = this.clothingImg;
  //   data['clothingApplyImg'] = this.clothingApplyImg;
  //   data['clothingInfo'] = this.clothingInfo;
  //   data['clothingName'] = this.clothingName;
  //   data['price'] = this.price;
  //   return data;
  // }
}
