import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_event.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
