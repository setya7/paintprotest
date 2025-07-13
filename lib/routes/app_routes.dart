abstract class Routes {
  static const products = _Paths.products;
  static const addAndUpdateProduct = _Paths.addAndUpdateProduct;
  Routes._();
}

abstract class _Paths {
  static const products = '/products';
  static const addAndUpdateProduct = '/add_product';
  _Paths._();
}

abstract class _Names {
  static const products = 'products';
  static const addAndUpdateProduct = 'add_product';
  _Names._();
}

abstract class Names {
  static const products = _Names.products;
  static const addAndUpdateProduct = _Names.addAndUpdateProduct;
  Names._();
}
