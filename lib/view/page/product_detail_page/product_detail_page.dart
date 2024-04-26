import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductDetailPageViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '민영기 염소탕',
          style: TextStyle(fontFamily: 'Jalnan', fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            const Text('상품 상세'),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.product.representativeImage,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.product.title),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('${widget.product.price}원'),
              ),
            ),
            const Divider(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '재료',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.product.ingredients,
                        style: const TextStyle(color: Color(0xFF555555)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '배송',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.delivery,
                    style: const TextStyle(
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Image.network(widget.product.images[22]),
            Image.network(widget.product.images[23]),
            Image.network(widget.product.images[24]),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(widget.product.title),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 32),
                                  child: Text('${widget.product.price}원'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 4, right: 8, bottom: 8),
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.zero),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  viewModel.minusCartCount();
                                                });
                                              },
                                              child: const Icon(Icons.remove)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text('${viewModel.cartCount}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  viewModel.plusCartCount();
                                                });
                                              },
                                              child: const Icon(Icons.add)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(''),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 16, right: 16, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('수량 ${viewModel.cartCount}개'),
                                      Text(
                                          '${viewModel.formatKoreanNumber(viewModel.cartCount * int.parse(widget.product.price.replaceAll(',', '')))}원')
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          backgroundColor:
                                              const Color(0xFF2F362F),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          '장바구니 담기',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                      });
                },
                child: const Text(
                  '장바구니',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: const Color(0xFF2F362F)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(widget.product.title),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 32),
                                  child: Text('${widget.product.price}원'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 4, right: 8, bottom: 8),
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.zero),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                              onTap: () {
                                                // setState(() {
                                                //   if (count > 1) count--;
                                                // });
                                                setState(() {
                                                  viewModel
                                                      .minusPurchaseCount();
                                                });
                                              },
                                              child: const Icon(Icons.remove)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                              '${viewModel.purchaseCount}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  viewModel.plusPurchaseCount();
                                                });

                                                // viewModel.plusCount();
                                              },
                                              child: const Icon(Icons.add)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(''),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 16, right: 16, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('수량 ${viewModel.purchaseCount}개'),
                                      Text(
                                          '${viewModel.formatKoreanNumber(viewModel.purchaseCount * int.parse(widget.product.price.replaceAll(',', '')))}원')
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          backgroundColor:
                                              const Color(0xFF2F362F),
                                        ),
                                        onPressed: () {
                                          context
                                              .push('/fill_order_page', extra: {
                                            'title': widget.product.title,
                                            'count': viewModel.purchaseCount,
                                            'price': widget.product.price
                                          });
                                        },
                                        child: const Text(
                                          '구매하기',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                      });
                },
                child: const Text(
                  '바로구매',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
