import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery_app/models/category.dart';

import '../../models/auth.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoadFailure extends CategoryState {
  String? reason;
  CategoryLoadFailure({required this.reason});
}

class CategoryLoadSuccess extends CategoryState {
  List<CategoryModel> categories = [];

  CategoryLoadSuccess({required this.categories});
  @override
  List<Object> get props => [];
}
