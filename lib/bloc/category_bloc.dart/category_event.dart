import 'package:equatable/equatable.dart';

import '../../models/auth.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}


class CategoryDataLoad extends CategoryEvent {
  @override
  List<Object?> get props => [];
}





