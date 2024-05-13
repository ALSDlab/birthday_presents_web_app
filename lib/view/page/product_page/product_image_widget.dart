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
            width: MediaQuery.of(context).size.width * 0.5,
            widthHeightRatio: 0.6,
            imageUrl: product.representativeImage,
          ),
        ),
        Text(product.title),
        Text('${product.price}원')
      ],
    );
  }
}
