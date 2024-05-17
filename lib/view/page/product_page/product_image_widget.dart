import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/product_model.dart';

import '../../../utils/image_load_widget.dart';

class ProductImageWidget extends StatelessWidget {
  final Product product;

  const ProductImageWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageLoadWidget(
            width: ((MediaQuery.of(context).size.width >= 1200) ? 1200 : MediaQuery.of(context).size.width) * 0.5,
            height: ((MediaQuery.of(context).size.width >= 1200) ? 1200 : MediaQuery.of(context).size.width) * 0.3,
            imageUrl: product.representativeImage,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        Text('${product.price}원')
      ],
    );
  }
}
