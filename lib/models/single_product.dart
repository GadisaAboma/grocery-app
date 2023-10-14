class SingleProductModel {
  final List<dynamic> detailImages;
  final String name;
  final String price;
  final String desc;
  final String shortDesc;

  SingleProductModel({
    required this.detailImages,
    required this.name,
    required this.desc,
    required this.price,
    required this.shortDesc,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) {
    return SingleProductModel(
        detailImages: json['detail_images'],
        name: json['name'],
        desc: json['long_description'],
        price: json['single_deal']['original_price'].toString(),
        shortDesc: json['short_description']);
  }
}
