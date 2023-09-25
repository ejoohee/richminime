class InteriorThemeModel {
  final String name, type, img, info, price;

  InteriorThemeModel.fromJson(Map<String, dynamic> json)
      : name = json['itemName'],
        type = json['itemType'],
        img = json['itemImg'],
        info = json['itemInfo'],
        price = json['price'];
}
