import 'package:equatable/equatable.dart';

import '../../models/auth.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductDataLoad extends ProductEvent {
  @override
  List<Object?> get props => [];
}
