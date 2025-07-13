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
/// @Date: 7/13/2025

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
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    logger.severe(widget.productsModel?.toJson());
    if (widget.productsModel != null) {
      etName.text = widget.productsModel?.name ?? "";
      etDescription.text = widget.productsModel?.description ?? "";
      if (widget.productsModel?.height != null) {
        etHeight.text = widget.productsModel!.height.toString();
      }
      if (widget.productsModel?.width != null) {
        etWidth.text = widget.productsModel!.width.toString();
      }
      if (widget.productsModel?.length != null) {
        etLength.text = widget.productsModel!.length.toString();
      }
      if (widget.productsModel?.weight != null) {
        etWeight.text = widget.productsModel!.weight.toString();
      }
      if (widget.productsModel?.price != null) {
        etPrice.text = widget.productsModel!.price.toString();
      }
      if (widget.productsModel?.categoryName != null) {
        etCategoryName.text = widget.productsModel!.categoryName!;
      }
      if (widget.productsModel?.image != null) {
        image = widget.productsModel!.image!;
      }
    }
    _addListenersToControllers();
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

  void _addListenersToControllers() {
    List<TextEditingController> controllers = [
      etName,
      etDescription,
      etHeight,
      etWidth,
      etLength,
      etWeight,
      etPrice,
      etCategoryName,
      etSku
    ];

    for (var controller in controllers) {
      controller.addListener(_validateForm);
    }
    _validateForm();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
      _isFormValid = _areAllFieldsValid();
    });
  }

  bool _areAllFieldsValid() {
    return etName.text.isNotEmpty &&
        etDescription.text.isNotEmpty &&
        etCategoryName.text.isNotEmpty &&
        _isNumeric(etHeight.text) &&
        _isNumeric(etWidth.text) &&
        _isNumeric(etLength.text) &&
        _isNumeric(etWeight.text) &&
        _isNumeric(etPrice.text) &&
        etSku.text.isNotEmpty;
  }

  bool _isNumeric(String str) {
    if (str.isEmpty) {
      return false;
    }
    return int.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Builder(builder: (context) {
          return BlocListener<ProductsBloc, ProductsState>(
            listener: (innerContext, state) {
              if (state is ProductsLoading) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  const SnackBar(content: Text('Memproses...')),
                );
              } else if (state is ProductsSuccessAdd) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  const SnackBar(content: Text('Produk berhasil ditambahkan!')),
                );
                Navigator.pop(innerContext, true);
              } else if (state is ProductsFailed) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text('Error: ${state.failedText}')),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(XSpace.marginL),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: etName,
                        decoration: const InputDecoration(label: Text("Product name")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama produk tidak boleh kosong';
                          }
                          return null; // Valid
                        },
                      ),
                      TextFormField(
                        controller: etDescription,
                        decoration: const InputDecoration(label: Text("Description")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: etCategoryName,
                        decoration: const InputDecoration(label: Text("Category name")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama kategori tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: etHeight,
                              decoration: const InputDecoration(label: Text("Height")),
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
                          const SizedBox(
                            width: XSpace.spaceL,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: etWidth,
                              decoration: const InputDecoration(label: Text("Width")),
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
                          const SizedBox(
                            width: XSpace.spaceL,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: etLength,
                              decoration: const InputDecoration(label: Text("Length")),
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
                      TextFormField(
                        controller: etWeight,
                        decoration: const InputDecoration(label: Text("Weight")),
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
                      TextFormField(
                        controller: etSku,
                        decoration: const InputDecoration(label: Text("SKU")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'SKU tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: etPrice,
                        decoration: const InputDecoration(label: Text("Price")),
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
                          : BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                if (state is ProductsLoadingAddProduct) {
                                  return const CircularProgressIndicator();
                                }
                                return ElevatedButton(
                                  onPressed: _isFormValid
                                      ? () {
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
                                        }
                                      : (){},
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
