import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('민영기 염소탕'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2),
                ),
                hintText: '찾으시는 상품을 검색하세요',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Text('상품 목록'),
          Divider(),
        ],
      ),
    );
  }
}
