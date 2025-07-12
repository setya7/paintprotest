import 'package:dio/dio.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';

import '../../../../core/constants/network_constant.dart';
import '../../../../core/network/rest_api/error/dio_error_handler.dart';
import '../../../../core/network/rest_api/error/exceptions.dart';

abstract class ProductsDatasource {
  Future<ProductsModel> getProducts();
}

class ProductsDatasourceImpl implements ProductsDatasource {
  final Dio dio;

  ProductsDatasourceImpl(this.dio);

  CancelToken cancelToken = CancelToken();

  @override
  Future<ProductsModel> getProducts() async {
    try {
      final result = await dio.get("$apiUrl/products");
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return ProductsModel.fromJson(result.data);
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
