import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/single_product_bloc/single_product_event.dart';
import 'package:grocery_app/bloc/single_product_bloc/single_product_state.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/single_product.dart';
import 'dart:developer' as developer;

import 'package:grocery_app/repository/product_repository.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final ProductRepository productRepository;

  SingleProductBloc({required this.productRepository})
      : super(SingleProductLoading()) {
    on<SingleProductDataLoad>((event, emit) async {
      try {
        emit(SingleProductLoading());

        SingleProductModel product =
            await productRepository.laodSingleProduct(event.id);
        emit(SingleProductLoadSuccess(product: product));
      } catch (e) {
        print(e);
        emit(SingleProductLoadFailure(reason: e.toString()));
      }
    });
  }
}
