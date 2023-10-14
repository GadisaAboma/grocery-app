import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_event.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_state.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_event.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_state.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';

import 'package:grocery_app/repository/category_repository.dart';
import 'package:grocery_app/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductLoading()) {
    on<ProductDataLoad>((event, emit) async {
      try {
        emit(ProductLoading());
        List<ProductModel> prodcuts =
            await productRepository.laodLatestProducts();
        emit(ProductLoadSuccess(products: prodcuts));
      } catch (e) {
        emit(ProductLoadFailure(reason: e.toString()));
      }
    });
  }
}
