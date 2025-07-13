import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paintprotest/features/products/data/models/products_model.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_event.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_state.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../routes/app_routes.dart';
import '../bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsBloc>()..add(GetProducts()),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: BlocConsumer<ProductsBloc, ProductsState>(
              listener: (context, state) {
                if (state is ProductsFailed) {
                  print("ini state ProductsFailed ${state.failedText}");
                }
              },
              builder: (context, state) {
                final List<ProductsModel> products = context.read<ProductsBloc>().products;
                if (state is ProductsLoaded) {
                  return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              context.push(Routes.addAndUpdateProduct, extra: products[index]);
                            },
                            child: ListTile(title: Text(products[index].name ?? "")));
                      });
                }

                if (state is ProductsFailed) {
                  return Center(child: Text(state.failedText));
                }

                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return products.isEmpty
                    ? const Center(child: Text("No products found."))
                    : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text(products[index].name ?? ""));
                        });
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.push(Routes.addAndUpdateProduct).then((val){
                  if (val == 'addSuccess'){
                    innerContext.read<ProductsBloc>().add(GetProducts());
                  }
                });
              },
              tooltip: 'Tambah Produk',
              child: const Icon(Icons.add),
            ),
          );
        }
      ),
    );
  }
}
