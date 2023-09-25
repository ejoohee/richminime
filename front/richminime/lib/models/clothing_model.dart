class ClothingModel {
  final String type, img, info, name, price;

  ClothingModel.fromJson(Map<String, dynamic> json)
      : type = json['clothingType'],
        img = json['clothingImg'],
        info = json['clothingInfo'],
        name = json['clothingName'],
        price = json['price'];
}
