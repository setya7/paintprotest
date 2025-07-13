import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paintprotest/core/utils/log/app_logger.dart';
import 'package:paintprotest/features/products/presentation/bloc/products_state.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../data/models/products_model.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';

/// @Author: christyastama
/// @Date: 7/12/2025

class AddAndUpdateProduct extends StatefulWidget {
  final ProductsModel? productsModel;

  const AddAndUpdateProduct({super.key, this.productsModel});

  @override
  State<AddAndUpdateProduct> createState() => _AddAndUpdateProductState();
}

class _AddAndUpdateProductState extends State<AddAndUpdateProduct> {
  final etName = TextEditingController();
  final etDescription = TextEditingController();
  final etHeight = TextEditingController();
  final etWidth = TextEditingController();
  final etLength = TextEditingController();
  final etWeight = TextEditingController();
  final etPrice = TextEditingController();
  final etCategoryName = TextEditingController();
  final etSku = TextEditingController();
  String image = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    logger.severe(widget.productsModel?.toJson());
    if (widget.productsModel != null) {
      etName.text = widget.productsModel!.name ?? "";
      etDescription.text = widget.productsModel!.description ?? "";
      etCategoryName.text = widget.productsModel!.categoryName ?? "";
      etSku.text = widget.productsModel!.sku ?? "";
      image = widget.productsModel!.image ?? "";

      etHeight.text = widget.productsModel!.height?.toString() ?? "";
      etWidth.text = widget.productsModel!.width?.toString() ?? "";
      etLength.text = widget.productsModel!.length?.toString() ?? "";
      etWeight.text = widget.productsModel!.weight?.toString() ?? "";
      etPrice.text = widget.productsModel!.price?.toString() ?? "";
    }
  }

  @override
  void dispose() {
    etName.dispose();
    etDescription.dispose();
    etHeight.dispose();
    etWidth.dispose();
    etLength.dispose();
    etWeight.dispose();
    etPrice.dispose();
    etCategoryName.dispose();
    etSku.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => sl<ProductsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.productsModel != null ? 'Edit Product' : 'Add Product'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        body: Builder(builder: (context) {
          return BlocListener<ProductsBloc, ProductsState>(
            listener: (innerContext, state) {
              print("ini adalah statenya $state");
              if (state is ProductsLoading) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text('Memproses...', style: TextStyle(color: colorScheme.onSurface)), backgroundColor: colorScheme.surface),
                );
              }

              if (state is ProductsSuccessAdd) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text('Produk berhasil ditambahkan!', style: TextStyle(color: colorScheme.onPrimary)), backgroundColor: colorScheme.primary),
                );
                innerContext.pop(true);
              }

              if (state is ProductsSuccessUpdate) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text('Produk berhasil diubah!', style: TextStyle(color: colorScheme.onPrimary)), backgroundColor: colorScheme.primary),
                );
                innerContext.pop(true);
              }

              if (state is ProductsSuccessDelete) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text('Produk berhasil dihapus!', style: TextStyle(color: colorScheme.onError)), backgroundColor: colorScheme.error),
                );
                innerContext.pop(true);
              }

              if (state is ProductsFailed) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text('Error: ${state.failedText}', style: TextStyle(color: colorScheme.onError)), backgroundColor: colorScheme.error),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(XSpace.marginL),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: etName,
                        decoration: InputDecoration(
                          labelText: "Product name",
                          hintText: "Enter product name",
                          prefixIcon: const Icon(Icons.shopping_bag_outlined),
                          suffixIcon: etName.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => etName.clear(),
                          )
                              : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama produk tidak boleh kosong';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: XSpace.spaceL),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: etDescription,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          hintText: "Enter product description",
                          prefixIcon: Icon(Icons.description),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: XSpace.spaceL),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: etCategoryName,
                        decoration: const InputDecoration(
                          labelText: "Category name",
                          hintText: "Enter category name",
                          prefixIcon: Icon(Icons.category),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama kategori tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: XSpace.spaceL),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: etHeight,
                              decoration: const InputDecoration(
                                labelText: "Height",
                                hintText: "cm",
                                prefixIcon: Icon(Icons.height),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kosong';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Angka';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: XSpace.spaceL),
                          Expanded(
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: etWidth,
                              decoration: const InputDecoration(
                                labelText: "Width",
                                hintText: "cm",
                                prefixIcon: Icon(Icons.width_full),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kosong';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Angka';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: XSpace.spaceL),
                          Expanded(
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: etLength,
                              decoration: const InputDecoration(
                                labelText: "Length",
                                hintText: "cm",
                                prefixIcon: Icon(Icons.straighten),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kosong';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Angka';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: XSpace.spaceL),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: etWeight,
                        decoration: const InputDecoration(
                          labelText: "Weight",
                          hintText: "grams",
                          prefixIcon: Icon(Icons.scale),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Berat tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Harus angka';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: XSpace.spaceL),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: etSku,
                        decoration: const InputDecoration(
                          labelText: "SKU",
                          hintText: "Enter Stock Keeping Unit",
                          prefixIcon: Icon(Icons.qr_code),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'SKU tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: XSpace.spaceL),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: etPrice,
                        decoration: const InputDecoration(
                          labelText: "Price",
                          hintText: "Enter price in IDR",
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Harus angka';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: XSpace.spaceL,
                      ),
                      (widget.productsModel != null)
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                if (state is ProductsLoadingUpdateProduct) {
                                  return const CircularProgressIndicator();
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<ProductsBloc>().add(UpdateProduct(ProductsModel(
                                          id: widget.productsModel?.id,
                                          categoryName: etCategoryName.text,
                                          categoryId: 1,
                                          description: etDescription.text,
                                          height: int.parse(etHeight.text),
                                          image: image,
                                          length: int.parse(etLength.text),
                                          name: etName.text,
                                          price: int.parse(etPrice.text),
                                          sku: etSku.text,
                                          weight: int.parse(etWeight.text),
                                          width: int.parse(etWidth.text))));
                                    }
                                  },
                                  child: const Text('Update Product'),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: XSpace.paddingL),
                          Expanded(
                            child: BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                if (state is ProductsLoadingDelete) {
                                  return const CircularProgressIndicator();
                                }

                                return ElevatedButton(
                                  onPressed: () {
                                    if (widget.productsModel?.id != null) {
                                      context.read<ProductsBloc>().add(DeleteProduct(widget.productsModel!.id!));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('ID produk tidak ditemukan untuk dihapus.', style: TextStyle(color: colorScheme.onError)), backgroundColor: colorScheme.error),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.error,
                                    foregroundColor: colorScheme.onError,
                                  ),
                                  child: const Text('Hapus Product'),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                          : BlocBuilder<ProductsBloc, ProductsState>(
                        builder: (context, state) {
                          if (state is ProductsLoadingAddProduct) {
                            return const CircularProgressIndicator();
                          }

                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ProductsBloc>().add(AddProducts(ProductsModel(
                                    categoryName: etCategoryName.text,
                                    categoryId: 1,
                                    description: etDescription.text,
                                    height: int.parse(etHeight.text),
                                    image: image,
                                    length: int.parse(etLength.text),
                                    name: etName.text,
                                    price: int.parse(etPrice.text),
                                    sku: etSku.text,
                                    weight: int.parse(etWeight.text),
                                    width: int.parse(etWidth.text))));
                              }
                            },
                            child: const Text('Tambah Product'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}