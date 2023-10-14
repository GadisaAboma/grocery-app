import 'package:equatable/equatable.dart';


abstract class SingleProductEvent extends Equatable {
  const SingleProductEvent();
}

class SingleProductDataLoad extends SingleProductEvent {
  final String id;

  const SingleProductDataLoad({required this.id});
  @override
  List<Object?> get props => [id];
}
