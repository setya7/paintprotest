import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  String? id;
  int? categoryId;
  String? categoryName;
  String? sku;
  String? name;
  String? description;
  int? weight;
  int? width;
  int? length;
  int? height;
  String? image;
  int? price;

  ProductsModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.sku,
    this.name,
    this.description,
    this.weight,
    this.width,
    this.length,
    this.height,
    this.image,
    this.price,
  });

  ProductsModel copyWith({
    String? id,
    int? categoryId,
    String? categoryName,
    String? sku,
    String? name,
    String? description,
    int? weight,
    int? width,
    int? length,
    int? height,
    String? image,
    int? price,
  }) =>
      ProductsModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        sku: sku ?? this.sku,
        name: name ?? this.name,
        description: description ?? this.description,
        weight: weight ?? this.weight,
        width: width ?? this.width,
        length: length ?? this.length,
        height: height ?? this.height,
        image: image ?? this.image,
        price: price ?? this.price,
      );

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json["_id"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    sku: json["sku"],
    name: json["name"],
    description: json["description"],
    weight: json["weight"],
    width: json["width"],
    length: json["length"],
    height: json["height"],
    image: json["image"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "sku": sku,
    "name": name,
    "description": description,
    "weight": weight,
    "width": width,
    "length": length,
    "height": height,
    "image": image,
    "price": price,
  };
}
