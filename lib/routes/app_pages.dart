import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';
import 'package:paintprotest/features/products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/dependency_injection/injection_container.dart';
import '../features/products/presentation/bloc/products_bloc.dart';
import '../features/products/presentation/pages/add_update_product.dart';
import 'app_routes.dart';

final router = GoRouter(
  initialLocation: '/products',
  navigatorKey: GlobalNavigation.instance.navigatorKey,
  routes: [
    GoRoute(
        name: Names.products,
        path: Routes.products,
        builder: (context, state) {
          return const ProductsPage();
        }),
    GoRoute(
        name: Names.addAndUpdateProduct,
        path: Routes.addAndUpdateProduct,
        builder: (context, state) {
          final product = state.extra as ProductsModel?;
          return AddAndUpdateProduct(productsModel: product);
        }),
  ],
);

class GlobalNavigation {
  static final GlobalNavigation instance = GlobalNavigation._internal();
  GlobalNavigation._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
