import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase_base.dart';
import '../../data/models/products_model.dart';
import '../repositories/products_repository.dart';

/// @Author: christyastama
/// @Date: 7/12/2025

class UpdateProductsUseCase extends UseCaseBase<dynamic, ProductsModel>{
  final ProductsRepository repository;

  UpdateProductsUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(ProductsModel params) async {
    return await repository.updateProduct(params);
  }
}
