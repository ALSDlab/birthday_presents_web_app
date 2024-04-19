import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/product_page/product_image_widget.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    Future.microtask(() {
      final ProductViewModel viewModel = context.read<ProductViewModel>();
      viewModel.getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ProductViewModel();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('민영기 염소탕'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
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
            Text( '${state.products.length}'),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 32,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  print(state.products.length);
                  return ProductImageWidget(
                    product: state.products[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
