import 'package:paintprotest/features/products/domain/usecases/add_product.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_bloc.dart';

import '../../core/dependency_injection/injection_container.dart';
import '../../core/network/rest_api/dio_network.dart';
import 'data/datasources/products_datasource.dart';
import 'data/repositories/products_repository_impl.dart';
import 'domain/repositories/products_repository.dart';
import 'domain/usecases/get_products_use_case.dart';
import 'domain/usecases/update_product.dart';

/// @Author: christyastama
/// @Date: 7/12/2025

initProductsInjections() {
  sl.registerSingleton<ProductsDatasource>(ProductsDatasourceImpl(DioNetwork.appAPI));
  sl.registerSingleton<ProductsRepository>(ProductsRepositoryImpl(sl()));
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(sl()));
  sl.registerSingleton<AddProductsUseCase>(AddProductsUseCase(sl()));
  sl.registerSingleton<UpdateProductsUseCase>(UpdateProductsUseCase(sl()));
  sl.registerFactory(() => ProductsBloc(
      getProducts: sl<GetProductsUseCase>(),
      addProductsUseCase: sl<AddProductsUseCase>(),
      updateProductsUseCase: sl<UpdateProductsUseCase>()));
}
