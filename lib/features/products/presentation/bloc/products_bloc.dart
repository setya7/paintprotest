import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/core/utils/usecases/usecase_base.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_event.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_state.dart';

import '../../domain/usecases/get_products_use_case.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final etName = TextEditingController();
  final etDescription = TextEditingController();
  final etHeight = TextEditingController();
  final etWidth = TextEditingController();
  final etLength = TextEditingController();
  final etWeight = TextEditingController();
  final etPrice = TextEditingController();
  final etCategoryName = TextEditingController();
  String image = "";

  final GetProductsUseCase getProducts;

  ProductsModel productsModel = ProductsModel();
  List<ProductsModel> products = [];

  ProductsBloc({required this.getProducts}) : super(ProductsInitial()) {
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
  }
}
