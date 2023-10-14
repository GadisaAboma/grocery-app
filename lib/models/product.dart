class ProductModel {
  final String primaryImage;
  final String id;
  final String name;
  final String price;
  final bool favorite;

  ProductModel(
      {required this.primaryImage,
      required this.name,
      required this.id,
      required this.price,
      required this.favorite});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        primaryImage: json['primary_image'],
        name: json['name'],
        id: json['id'],
        favorite: json['favorite'],
        price: json['single_deal']['original_price']);
  }
}
