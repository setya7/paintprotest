import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/core/utils/log/app_logger.dart';
import 'package:paintprotest/core/utils/usecases/usecase_base.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';
import 'package:paintprotest/features/products/domain/usecases/add_product.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_event.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_state.dart';

import '../../domain/usecases/get_products_use_case.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final GetProductsUseCase getProducts;
  final AddProductsUseCase addProductsUseCase;

  ProductsModel productsModel = ProductsModel();
  List<ProductsModel> products = [];

  ProductsBloc({required this.getProducts, required this.addProductsUseCase}) : super(ProductsInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductsLoading());
      final result = await getProducts.call(NoParams());
      result.fold((ifLeft) {
        emit(ProductsFailed(ifLeft.message));
      }, (ifRight) {
        products = ifRight;
        emit(ProductsLoaded(ifRight));
      });
    });

    on<AddProducts>((event, emit) async {
      emit(ProductsLoadingAddProduct());
      final result = await addProductsUseCase.call(event.body!);
      result.fold((ifLeft) {
        emit(ProductsFailed(ifLeft.message));
      }, (ifRight) {
        emit(ProductsSuccessAdd());
      });
    });
  }
}
