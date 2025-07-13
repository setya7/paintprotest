import 'package:flutter/material.dart';

import '../../data/models/products_model.dart';

/// @Author: christyastama
/// @Date: 7/13/2025

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.image != null && product.image!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.image!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              product.name ?? 'Product Name Not Available',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price?.toStringAsFixed(0) ?? 'N/A'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary, // Using primary color for price
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Category: ${product.categoryName ?? 'Unknown'}',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              'SKU: ${product.sku ?? 'N/A'}',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Text(
              product.description ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                Chip(
                  label: Text('Weight: ${product.weight ?? 'N/A'} gr'),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest, // Using a surface variant color
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Chip(
                  label: Text('Dimensions: ${product.height ?? 'N/A'}x${product.width ?? 'N/A'}x${product.length ?? 'N/A'} cm'),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}