import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/utils/gif_progress_bar.dart';
import 'package:myk_market_app/view/page/product_page/product_image_widget.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.navSetState});

  final bool Function(int)? navSetState;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final filterController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() async {
      final ProductViewModel viewModel = context.read<ProductViewModel>();
      await viewModel.getProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        title: const Text(
          '민영기 염소탕',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Container(
          color: const Color(0xFFFFF8E7),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: viewModel.onChanged,
                    controller: filterController,
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(width: 2),
                      ),
                      hintText: '찾으시는 상품을 검색하세요',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Divider(),
                ),
                const Text('상품 목록'),
                const Divider(),
                // Text( '${state.products.length}'),
                (state.isLoading)
                    ? const Expanded(child: Center(child: GifProgressBar()))
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32,
                          ),
                          itemCount: viewModel.products.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.push('/product_detail_page', extra: {
                                  'product': viewModel.products[index],
                                  'navSetState': widget.navSetState
                                });
                              },
                              child: ProductImageWidget(
                                product: viewModel.products[index],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
