import 'package:badges/badges.dart' as badges;
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import '../../../utils/gif_progress_bar.dart';
import '../../../utils/image_load_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.navSetState,
    required this.hideNavBar,
  });

  final Product product;
  final bool Function(int) navSetState;
  final bool Function(bool) hideNavBar;

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
        scrolledUnderElevation: 0,
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 5),
            badgeContent: Text('${state.forBadgeList.length}'),
            showBadge: _showCartBadge,
            child: IconButton(
              onPressed: () {
                context.go('/shopping_cart_page', extra: {
                  'navSetState': widget.navSetState,
                  'hideNavBar': widget.hideNavBar
                });
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
              fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width >= 1200)
              ? 1200
              : MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Container(
              color: const Color(0xFFFFF8E7),
              child: (state.isLoading)
                  ? Center(
                      child: GifProgressBar(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: 5.0,
                          left: 5.0,
                          right: 5.0,
                          bottom: state.showSnackbarPadding
                              ? MediaQuery.of(context).padding.bottom + 48.0
                              : 0), // Snackbar 높이만큼 padding 추가
                      child: Column(
                        children: [
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('상품 상세'),
                          ),
                          const Divider(),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ImageLoadWidget(
                                    width: (MediaQuery.of(context).size.width >=
                                            1200)
                                        ? 1200
                                        : MediaQuery.of(context).size.width,
                                    height:
                                        ((MediaQuery.of(context).size.width >=
                                                    1200)
                                                ? 1200
                                                : MediaQuery.of(context)
                                                    .size
                                                    .width) *
                                            0.58,
                                    imageUrl:
                                        widget.product.representativeImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.product.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
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
                                            style: const TextStyle(
                                                color: Color(0xFF555555)),
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ImageLoadWidget(
                                      width: (MediaQuery.of(context)
                                                  .size
                                                  .width >=
                                              1200)
                                          ? 1200
                                          : MediaQuery.of(context).size.width,
                                      imageUrl: widget.product.images[index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  itemCount: widget.product.images.length,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex: 2, child: Container()),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return SizedBox(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          1200)
                                                      ? 1200
                                                      : MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Text(
                                                          widget.product.title,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                bottom: 32),
                                                        child: Text(
                                                            '${widget.product.price}원'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 4,
                                                                right: 8,
                                                                bottom: 8),
                                                        child: Container(
                                                          width: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        viewModel
                                                                            .minusCartCount();
                                                                      });
                                                                    },
                                                                    child: const Icon(
                                                                        Icons
                                                                            .remove)),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                    '${viewModel.cartCount}'),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        viewModel
                                                                            .plusCartCount();
                                                                      });
                                                                    },
                                                                    child: const Icon(
                                                                        Icons
                                                                            .add)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(''),
                                                      const Divider(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 16,
                                                                right: 16,
                                                                bottom: 4),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '수량 ${viewModel.cartCount}개'),
                                                            Text(
                                                              '${viewModel.formatKoreanNumber(viewModel.cartCount * int.parse(widget.product.price.replaceAll(',', '')))}원',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 17),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child:
                                                                OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFF2F362F),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                final createdDate = DateTime
                                                                        .now()
                                                                    .toString()
                                                                    .substring(
                                                                        2, 10)
                                                                    .replaceAll(
                                                                        '-',
                                                                        '');
                                                                ShoppingProductForCart item = ShoppingProductForCart(
                                                                    orderId: viewModel
                                                                        .generateLicensePlate(
                                                                            createdDate),
                                                                    productId: widget
                                                                        .product
                                                                        .productId,
                                                                    orderProductName: widget
                                                                        .product
                                                                        .title,
                                                                    price: widget
                                                                        .product
                                                                        .price,
                                                                    representativeImage: widget
                                                                        .product
                                                                        .representativeImage,
                                                                    count: viewModel
                                                                        .cartCount);
                                                                await viewModel
                                                                    .addToShoppingCartList(
                                                                        item,
                                                                        context);
                                                                final newBadgeCount =
                                                                    await viewModel
                                                                        .getBadgeCount();
                                                                widget.navSetState(
                                                                    newBadgeCount);
                                                              },
                                                              child: const Text(
                                                                '장바구니 담기',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
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
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          // shape: const RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.zero),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          backgroundColor:
                                              const Color(0xFF2F362F)),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return SizedBox(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          1200)
                                                      ? 1200
                                                      : MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Text(
                                                          widget.product.title,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                bottom: 32),
                                                        child: Text(
                                                            '${widget.product.price}원'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 4,
                                                                right: 8,
                                                                bottom: 8),
                                                        child: Container(
                                                          width: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        viewModel
                                                                            .minusPurchaseCount();
                                                                      });
                                                                    },
                                                                    child: const Icon(
                                                                        Icons
                                                                            .remove)),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                    '${viewModel.purchaseCount}'),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        viewModel
                                                                            .plusPurchaseCount();
                                                                      });
                                                                    },
                                                                    child: const Icon(
                                                                        Icons
                                                                            .add)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(''),
                                                      const Divider(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 16,
                                                                right: 16,
                                                                bottom: 4),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '수량 ${viewModel.purchaseCount}개'),
                                                            Text(
                                                              '${viewModel.formatKoreanNumber(viewModel.purchaseCount * int.parse(widget.product.price.replaceAll(',', '')))}원',
                                                              style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child:
                                                                OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFF2F362F),
                                                              ),
                                                              onPressed: () {
                                                                final createdDate = DateTime
                                                                        .now()
                                                                    .toString()
                                                                    .substring(
                                                                        2, 10)
                                                                    .replaceAll(
                                                                        '-',
                                                                        '');
                                                                final OrderModel
                                                                    directOrderItem =
                                                                    OrderModel(
                                                                  orderId: viewModel
                                                                      .generateLicensePlate(
                                                                          createdDate),
                                                                  productId: widget
                                                                      .product
                                                                      .productId,
                                                                  orderProductName:
                                                                      widget
                                                                          .product
                                                                          .title,
                                                                  representativeImage:
                                                                      widget
                                                                          .product
                                                                          .representativeImage,
                                                                  price: widget
                                                                      .product
                                                                      .price,
                                                                  count: viewModel
                                                                      .purchaseCount,
                                                                  orderedDate:
                                                                      createdDate,
                                                                  payAndStatus:
                                                                      0,
                                                                );
                                                                final List<
                                                                        OrderModel>
                                                                    orderItemList =
                                                                    [
                                                                  directOrderItem
                                                                ];
                                                                Navigator.pop(
                                                                    context);
                                                                context.push(
                                                                    '/shopping_cart_page/fill_order_page',
                                                                    extra: {
                                                                      'orderModelList':
                                                                          orderItemList,
                                                                      'navSetState':
                                                                          widget
                                                                              .navSetState,
                                                                      'hideNavBar':
                                                                          widget
                                                                              .hideNavBar
                                                                    });
                                                                // context.push('/fill_order_page',
                                                                //     extra: [directOrderItem]);
                                                              },
                                                              child: const Text(
                                                                '구매하기',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
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
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: Container()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
