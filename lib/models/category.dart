class CategoryModel {
  final String primaryImage;
  final String name;

  CategoryModel({
    required this.primaryImage,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      primaryImage: json['primary_image'],
      name: json['name'],
    );
  }
}
