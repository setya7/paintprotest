import 'package:get_it/get_it.dart';

import '../../features/products/product_injections.dart';
import '../network/rest_api/dio_network.dart';
import '../utils/log/app_logger.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register services
  await initDioInjections();
  await initProductsInjections();

  // Register blocs
  
  // Register repositories
  
  // Register data sources
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}