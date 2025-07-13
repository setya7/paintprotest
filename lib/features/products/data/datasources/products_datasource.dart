import 'package:dio/dio.dart';
import 'package:paintprotest/core/utils/log/app_logger.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';

import '../../../../core/constants/network_constant.dart';
import '../../../../core/network/rest_api/error/dio_error_handler.dart';
import '../../../../core/network/rest_api/error/exceptions.dart';

abstract class ProductsDatasource {
  Future<List<ProductsModel>> getProducts();
  Future<dynamic> addProduct(ProductsModel param);
  Future<dynamic> updateProduct(ProductsModel param);
}

class ProductsDatasourceImpl implements ProductsDatasource {
  final Dio dio;

  ProductsDatasourceImpl(this.dio);

  CancelToken cancelToken = CancelToken();

  @override
  Future<List<ProductsModel>> getProducts() async {
    try {
      final result = await dio.get("$apiUrl/$apiKey/products");
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return (result.data as List).map((e) => ProductsModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future addProduct(ProductsModel param)  async {
    logger.severe(param.toJsonAddUpdateProduct());
    try {
      final result = await dio.post("$apiUrl/$apiKey/products", data: param.toJsonAddUpdateProduct());
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return result.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future updateProduct(ProductsModel param) async {
    logger.severe("param.id ${param.id}");
    try {
      final result = await dio.put("$apiUrl/$apiKey/products/${param.id}", data: param.toJsonAddUpdateProduct());
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return result.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
