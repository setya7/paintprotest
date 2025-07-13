import 'package:equatable/equatable.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}
final class ProductsLoadingDelete extends ProductsState {}
final class ProductsLoadingUpdateProduct extends ProductsState {}
final class ProductsLoadingAddProduct extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductsModel>? productsModel;

  const ProductsLoaded(this.productsModel);
}
final class ProductsSuccessDelete extends ProductsState {}
final class ProductsSuccessUpdate extends ProductsState {}
final class ProductsSuccessAdd extends ProductsState {}


final class ProductsFailed extends ProductsState {
  final String failedText;

  const ProductsFailed(this.failedText);
}

