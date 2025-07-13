import 'package:dartz/dartz.dart';
import 'package:paintprotest/core/error/failures.dart';
import 'package:paintprotest/features/products/domain/repositories/products_repository.dart';

import '../../../../core/utils/usecases/usecase_base.dart';
import '../../data/models/products_model.dart';

class GetProductsUseCase extends UseCaseBase<List<ProductsModel>, NoParams>{
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductsModel>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
