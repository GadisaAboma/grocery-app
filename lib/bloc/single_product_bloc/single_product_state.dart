import 'package:equatable/equatable.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/single_product.dart';

class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object> get props => [];
}

class SingleProductLoading extends SingleProductState {}

class SingleProductLoadFailure extends SingleProductState {
  String? reason;
  SingleProductLoadFailure({required this.reason});
}

class SingleProductLoadSuccess extends SingleProductState {
  SingleProductModel product;

  SingleProductLoadSuccess({required this.product});
  @override
  List<Object> get props => [product];
}
