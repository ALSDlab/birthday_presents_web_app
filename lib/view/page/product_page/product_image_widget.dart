import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/product_model.dart';

class ProductImageWidget extends StatelessWidget {
  Product product;

  ProductImageWidget({super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: Image.network(
            product.representativeImage,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        Text(product.title),
        Text(product.price as String)
      ],
    );
  }
}
