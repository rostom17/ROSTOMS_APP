import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rostoms_app/features/products/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _resizeTitle(product.title),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(CupertinoIcons.heart, color: Colors.grey),
              ],
            ),
            Image.network(
              product.thumbnail,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) =>
                  Center(child: Icon(Icons.broken_image)),
            ),
            Text(
              "\$${product.price}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  String _resizeTitle(String title) {
    return (title.length < 10) ? title : "${title.substring(0, 9)}...";
  }
}
