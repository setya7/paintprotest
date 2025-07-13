import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/core/utils/log/app_logger.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../data/models/products_model.dart';
import '../bloc/products_bloc.dart';

/// @Author: christyastama
/// @Date: 7/13/2025

class AddAndUpdateProduct extends StatefulWidget {
  final ProductsModel? productsModel;
  const AddAndUpdateProduct({super.key, this.productsModel});

  @override
  State<AddAndUpdateProduct> createState() => _AddAndUpdateProductState();
}

class _AddAndUpdateProductState extends State<AddAndUpdateProduct> {
  @override
  void initState() {
    super.initState();
    logger.severe(widget.productsModel?.toJson());
    if (widget.productsModel != null) {
      context.read<ProductsBloc>().etName.text = widget.productsModel?.name ?? "";
      context.read<ProductsBloc>().etDescription.text = widget.productsModel?.description ?? "";
      if (widget.productsModel?.height != null) {
        context.read<ProductsBloc>().etHeight.text = widget.productsModel!.height.toString();
      }
      if (widget.productsModel?.width != null) {
        context.read<ProductsBloc>().etWidth.text = widget.productsModel!.width.toString();
      }
      if (widget.productsModel?.length != null) {
        context.read<ProductsBloc>().etLength.text = widget.productsModel!.length.toString();
      }
      if (widget.productsModel?.weight != null) {
        context.read<ProductsBloc>().etWeight.text = widget.productsModel!.weight.toString();
      }
      if (widget.productsModel?.price != null) {
        context.read<ProductsBloc>().etPrice.text = widget.productsModel!.price.toString();
      }
      if (widget.productsModel?.categoryName != null) {
        context.read<ProductsBloc>().etCategoryName.text = widget.productsModel!.categoryName!;
      }
      if (widget.productsModel?.image != null) {
        context.read<ProductsBloc>().image = widget.productsModel!.image!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(XSpace.marginL),
          child: Column(
            children: [
              TextFormField(
                controller: context.read<ProductsBloc>().etName,
                decoration: const InputDecoration(label: Text("Product name")),
              ),
              TextFormField(
                controller: context.read<ProductsBloc>().etDescription,
                decoration: const InputDecoration(label: Text("Description")),
              ),
              TextFormField(
                controller: context.read<ProductsBloc>().etCategoryName,
                decoration: const InputDecoration(label: Text("Category name")),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: context.read<ProductsBloc>().etHeight,
                      decoration: const InputDecoration(label: Text("Height")),
                    ),
                  ),
                  const SizedBox(
                    width: XSpace.spaceL,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: context.read<ProductsBloc>().etWidth,
                      decoration: const InputDecoration(label: Text("Width")),
                    ),
                  ),
                  const SizedBox(
                    width: XSpace.spaceL,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: context.read<ProductsBloc>().etLength,
                      decoration: const InputDecoration(label: Text("Length")),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: context.read<ProductsBloc>().etWeight,
                decoration: const InputDecoration(label: Text("Weight")),
              ),
              TextFormField(
                controller: context.read<ProductsBloc>().etPrice,
                decoration: const InputDecoration(label: Text("Price")),
              ),
              const SizedBox(
                height: XSpace.spaceL,
              ),
              (widget.productsModel != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Update Product'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Hapus Product'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {},
                      child: const Text('Tambah Product'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
