import 'package:dartz/dartz.dart';
import 'package:paintprotest/core/error/failures.dart';

import '../../data/models/products_model.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductsModel>>> getProducts();
  Future<Either<Failure, dynamic>> addProducts();
  Future<Either<Failure, dynamic>> deleteProducts();
  Future<Either<Failure, dynamic>> updateProducts(ProductsModel param);
}
