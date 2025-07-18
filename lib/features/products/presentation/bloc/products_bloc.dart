import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/core/utils/usecases/usecase_base.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';
import 'package:paintprotest/features/products/domain/usecases/add_product_use_case.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_event.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_state.dart';

import '../../domain/usecases/delete_product_use_case.dart';
import '../../domain/usecases/get_products_use_case.dart';
import '../../domain/usecases/update_product_use_case.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProducts;
  final AddProductsUseCase addProductsUseCase;
  final UpdateProductsUseCase updateProductsUseCase;
  final DeleteProductsUseCase deleteProductsUseCase;

  ProductsModel productsModel = ProductsModel();
  List<ProductsModel> products = [];

  ProductsBloc(
      {required this.getProducts,
      required this.addProductsUseCase,
      required this.updateProductsUseCase,
      required this.deleteProductsUseCase})
      : super(ProductsInitial()) {
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
        emit(ProductsFailedAdd(ifLeft.message));
      }, (ifRight) {
        emit(ProductsSuccessAdd());
      });
    });

    on<UpdateProduct>((event, emit) async {
      emit(ProductsLoadingUpdateProduct());
      final result = await updateProductsUseCase.call(event.body!);
      result.fold((ifLeft) {
        emit(ProductsFailedUpdate(ifLeft.message));
      }, (ifRight) {
        emit(ProductsSuccessUpdate());
      });
    });

    on<DeleteProduct>((event, emit) async {
      emit(ProductsLoadingDelete());
      final result = await deleteProductsUseCase.call(event.id!);
      result.fold((ifLeft) {
        emit(ProductsFailedDelete(ifLeft.message));
      }, (ifRight) {
        emit(ProductsSuccessDelete());
      });
    });
  }
}
