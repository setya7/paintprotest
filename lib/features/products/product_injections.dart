import 'package:paintprotest/features/products/presentation/bloc/products_bloc.dart';

import '../../core/dependency_injection/injection_container.dart';
import '../../core/network/rest_api/dio_network.dart';
import 'data/datasources/products_datasource.dart';
import 'data/repositories/products_repository_impl.dart';
import 'domain/repositories/products_repository.dart';
import 'domain/usecases/get_products.dart';

/// @Author: christyastama
/// @Date: 7/12/2025

initUserMemberInjections() {
  sl.registerSingleton<ProductsDatasourceImpl>(ProductsDatasourceImpl(DioNetwork.appAPI));
  sl.registerSingleton<ProductsRepository>(ProductsRepositoryImpl(sl()));
  sl.registerSingleton<GetProducts>(GetProducts(sl()));
  // sl.registerFactory(() => ProductsBloc(getUserMemberUseCase: sl<GetUserMemberUseCase>()));
}