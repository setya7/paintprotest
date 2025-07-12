import 'package:dartz/dartz.dart';
import 'package:paintprotest/core/error/failures.dart';
import 'package:paintprotest/features/products/domain/repositories/products_repository.dart';

import '../../data/models/products_model.dart';

class GetProducts {
  final ProductsRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, ProductsModel>> call() async {
    return await repository.getProducts();
  }
}
