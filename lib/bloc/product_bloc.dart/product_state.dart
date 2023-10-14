import 'package:equatable/equatable.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoadFailure extends ProductState {
  String? reason;
  ProductLoadFailure({required this.reason});
}

class ProductLoadSuccess extends ProductState {
  List<ProductModel> products = [];

  ProductLoadSuccess({required this.products});
  @override
  List<Object> get props => [];
}
