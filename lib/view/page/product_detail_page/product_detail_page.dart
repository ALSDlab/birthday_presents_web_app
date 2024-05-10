import 'package:badges/badges.dart' as badges;
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import '../main_page/image_load_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.navSetState,
  });

  final Product product;
  final bool Function(int) navSetState;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late bool _showCartBadge;

  // @override
  // void initState() {
  //   Future.microtask(() async {
  //     final ProductDetailPageViewModel viewModel =
  //         context.read<ProductDetailPageViewModel>();
  //     await viewModel.getBadgeCount();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductDetailPageViewModel>();
    final state = viewModel.state;
    _showCartBadge = state.forBadgeList.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF2F362F),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 5),
            badgeContent: Text('${state.forBadgeList.length}'),
            showBadge: _showCartBadge,
            child: IconButton(
              onPressed: () {
                context.go('/shopping_cart_page',
                    extra: {'navSetState': widget.navSetState});
              },
              icon: const Icon(
                BootstrapIcons.cart_check,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: const Text(
          '민영기 염소탕',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 20, color: Colors.white),
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
              child: ImageLoadWidget(
                width: MediaQuery.of(context).size.width,
                widthHeightRatio: 0.6,
                imageUrl: widget.product.representativeImage,
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
            ImageLoadWidget(
              width: MediaQuery.of(context).size.width,
              widthHeightRatio: 2.5,
              imageUrl: widget.product.images[22],
            ),
            ImageLoadWidget(
              width: MediaQuery.of(context).size.width,
              widthHeightRatio: 2.5,
              imageUrl: widget.product.images[23],
            ),
            ImageLoadWidget(
              width: MediaQuery.of(context).size.width,
              widthHeightRatio: 2.5,
              imageUrl: widget.product.images[24],
            ),
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
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          ShoppingProductForCart item =
                                              ShoppingProductForCart(
                                                  orderId:
                                                      widget.product.productId,
                                                  orderProductName:
                                                      widget.product.title,
                                                  price: widget.product.price,
                                                  representativeImage: widget
                                                      .product
                                                      .representativeImage,
                                                  count: viewModel.cartCount);
                                          await viewModel.addToShoppingCartList(
                                              item, context);
                                          final newBadgeCount =
                                              await viewModel.getBadgeCount();
                                          widget.navSetState(newBadgeCount);

                                          // setState(() {});
                                        },
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
                                          final createdDate = DateTime.now()
                                              .toString()
                                              .substring(2, 10)
                                              .replaceAll('-', '');
                                          final OrderModel directOrderItem =
                                              OrderModel(
                                            orderId:
                                                viewModel.generateLicensePlate(
                                                    createdDate),
                                            orderProductName:
                                                widget.product.title,
                                            representativeImage: widget
                                                .product.representativeImage,
                                            price: widget.product.price,
                                            count: viewModel.purchaseCount,
                                            orderedDate: createdDate,
                                            payAndStatus: 0,
                                          );
                                          final List<OrderModel> orderItemList =
                                              [directOrderItem];
                                          GoRouter.of(context).go(
                                              '/shopping_cart_page/fill_order_page',
                                              extra: {
                                                'orderModelList': orderItemList
                                              });
                                          // context.push('/fill_order_page',
                                          //     extra: [directOrderItem]);
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
