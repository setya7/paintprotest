import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent {}
class AddProducts extends ProductsEvent {}
class DeleteProduct extends ProductsEvent {}
class UpdateProduct extends ProductsEvent {}
