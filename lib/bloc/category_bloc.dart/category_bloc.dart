import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_event.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_state.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/repository/auth_repository.dart';
import 'package:grocery_app/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryLoading()) {
    on<CategoryDataLoad>((event, emit) async {
      try {
        emit(CategoryLoading());
       List<CategoryModel> categories = await categoryRepository.loadCategory();
        emit(CategoryLoadSuccess(categories: categories));
      } catch (e) {
        emit(CategoryLoadFailure(reason: e.toString()));
      }
    });
  }
}
