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

class DeleteProduct extends ProductsEvent {
  final dynamic id;

  const DeleteProduct(this.id);
}

class UpdateProduct extends ProductsEvent {
  final ProductsModel? body;

  const UpdateProduct(this.body);
}
