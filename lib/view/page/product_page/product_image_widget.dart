import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/product_model.dart';

class ProductImageWidget extends StatelessWidget {
  final Product product;

  const ProductImageWidget({super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.representativeImage,
            fit: BoxFit.cover,
          ),
        ),
        Text(product.title),
        Text('${product.price}원')
      ],
    );
  }
}
