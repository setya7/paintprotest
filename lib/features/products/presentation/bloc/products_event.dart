import 'package:equatable/equatable.dart';

import '../../data/models/products_model.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent {}
class AddProducts extends ProductsEvent {
  final ProductsModel? body;

  const AddProducts(this.body);
}
class DeleteProduct extends ProductsEvent {}
class UpdateProduct extends ProductsEvent {}
