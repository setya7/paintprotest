import 'package:dartz/dartz.dart';
import 'package:paintprotest/core/error/failures.dart';
import 'package:paintprotest/features/products/data/datasources/products_datasource.dart';
import 'package:paintprotest/features/products/domain/entities/products.dart';
import 'package:paintprotest/features/products/domain/repositories/products_repository.dart';

import '../../../../core/network/rest_api/error/exceptions.dart';
import '../models/products_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ProductsModel>> getProducts() async {
    try {
      final result = await datasource.getProducts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CancelTokenException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addProducts() {
    // TODO: implement addProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> deleteProducts() {
    // TODO: implement deleteProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> updateProducts(ProductsModel param) {
    // TODO: implement updateProducts
    throw UnimplementedError();
  }
}
