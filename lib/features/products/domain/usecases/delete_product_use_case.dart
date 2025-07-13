import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase_base.dart';
import '../repositories/products_repository.dart';

/// @Author: christyastama
/// @Date: 7/12/2025

class DeleteProductsUseCase extends UseCaseBase<dynamic, dynamic>{
  final ProductsRepository repository;

  DeleteProductsUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(dynamic params) async {
    return await repository.deleteProducts(params);
  }
}
