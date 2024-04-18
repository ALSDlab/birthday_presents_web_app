import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/myk-market.appspot.com/o/product%2Fextract%2FIMG_3268.JPG?alt=media&token=429425ab-6a02-4ce1-80da-5ebcb8259e72',
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        Text('진심, 흑염소 진액'),
      ],
    );
  }
}
