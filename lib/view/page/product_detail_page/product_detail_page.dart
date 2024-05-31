import 'package:badges/badges.dart' as badges;
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/model/sales_model.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import '../../../utils/gif_progress_bar.dart';
import '../../../utils/image_load_widget.dart';
import '../../../utils/marketing_expression.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.navSetState,
    required this.hideNavBar,
    this.salesContent,
  });

  final ProductModel product;
  final bool Function(int) navSetState;
  final bool Function(bool) hideNavBar;
  final SalesModel? salesContent;

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
                                  child: Stack(
                                    children: [
                                      ImageLoadWidget(
                                        width: (MediaQuery.of(context)
                                                    .size
                                                    .width >=
                                                1200)
                                            ? 1200
                                            : MediaQuery.of(context).size.width,
                                        height: ((MediaQuery.of(context)
                                                        .size
                                                        .width >=
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

                                      MarketingExpression(
                                          visible: (widget.product.salesId >= 0),
                                          borderRadius: const BorderRadius.only(topLeft: Radius.zero),
                                          child: (widget.product.salesId == 0)
                                              ? Image.asset(
                                            'assets/gifs/hot_expression.gif',
                                            width: (kIsWeb) ? 100 : 80,
                                            height: (kIsWeb) ? 100 : 80,
                                            fit: BoxFit.cover,
                                          )
                                              :
                                          // (0 < product.salesId && product.salesId <= 100) ?
                                          Text(
                                            (widget.salesContent!.salesAmount > 0 &&
                                                widget.salesContent!.salesRate <= 0)
                                                ? ' ${widget.salesContent!.salesAmount}원 할인'
                                                : ' ${widget.salesContent!.salesRate}% 세일 ',
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900,
                                                color: Colors.white, backgroundColor: Color(0xffb158ff)),
                                          )
                                        // : Row(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text(
                                        //         (salesContent!.salesAmount > 0 &&
                                        //                 salesContent!.salesRate <= 0)
                                        //             ? ' ${salesContent!.salesAmount}원 할인 '
                                        //             : '${salesContent!.salesRate}% 세일',
                                        //         style: const TextStyle(
                                        //             color: Colors.white,
                                        //             backgroundColor: Colors.red),
                                        //       ),
                                        //       Image.asset(
                                        //         'assets/gifs/hot_expression.gif',
                                        //         width: (kIsWeb) ? 100 : 80,
                                        //         height: (kIsWeb) ? 100 : 80,
                                        //         fit: BoxFit.cover,
                                        //       )
                                        //     ],
                                        //   )
                                      )
                                    ],
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        (widget.salesContent == null)
                                            ? Text(
                                                '${widget.product.price}원',
                                              )
                                            : Text(
                                                '${widget.product.price}원',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Visibility(
                                          visible:
                                              (widget.salesContent != null),
                                          child: Text(
                                            '${(widget.salesContent != null) ? deCalculatedPrice(widget.product.price, widget.salesContent!) : widget.product.price}원',
                                          ),
                                        )
                                      ],
                                    ),
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
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            (widget.salesContent ==
                                                                    null)
                                                                ? Text(
                                                                    '${widget.product.price}원',
                                                                  )
                                                                : Text(
                                                                    '${widget.product.price}원',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        decoration:
                                                                            TextDecoration.lineThrough),
                                                                  ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Visibility(
                                                              visible: (widget
                                                                      .salesContent !=
                                                                  null),
                                                              child: Text(
                                                                '${(widget.salesContent != null) ? deCalculatedPrice(widget.product.price, widget.salesContent!) : widget.product.price}원',
                                                              ),
                                                            )
                                                          ],
                                                        ),
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
                                                              '${NumberFormat(
                                                                  '###,###,###,###')
                                                                  .format(viewModel
                                                                  .cartCount *
                                                                  int.parse((widget
                                                                      .salesContent !=
                                                                      null)
                                                                      ? deCalculatedPrice(
                                                                      widget.product
                                                                          .price,
                                                                      widget
                                                                          .salesContent!)
                                                                      .replaceAll(
                                                                      ',', '')
                                                                      : widget.product
                                                                      .price
                                                                      .replaceAll(
                                                                      ',', '')))
                                                              }원',
                                                            ),
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
                                                                ShoppingProductForCart
                                                                    item =
                                                                    ShoppingProductForCart(
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
                                                                  price: widget
                                                                      .product
                                                                      .price,
                                                                  representativeImage:
                                                                      widget
                                                                          .product
                                                                          .representativeImage,
                                                                  count: viewModel
                                                                      .cartCount,
                                                                  salesId: widget
                                                                      .product
                                                                      .salesId,
                                                                );
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
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            (widget.salesContent ==
                                                                    null)
                                                                ? Text(
                                                                    '${widget.product.price}원',
                                                                  )
                                                                : Text(
                                                                    '${widget.product.price}원',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        decoration:
                                                                            TextDecoration.lineThrough),
                                                                  ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Visibility(
                                                              visible: (widget
                                                                      .salesContent !=
                                                                  null),
                                                              child: Text(
                                                                '${(widget.salesContent != null) ? deCalculatedPrice(widget.product.price, widget.salesContent!) : widget.product.price}원',
                                                              ),
                                                            )
                                                          ],
                                                        ),
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
                                                              '${NumberFormat('###,###,###,###').format(viewModel.purchaseCount * int.parse((widget.salesContent != null) ? deCalculatedPrice(widget.product.price, widget.salesContent!).replaceAll(',', '') : widget.product.price.replaceAll(',', '')))}원',
                                                            ),
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
                                                                  salesId: widget.product.salesId,
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

  String deCalculatedPrice(String originalPrice, SalesModel? saleContent) {
    num resultPrice = int.parse(originalPrice.replaceAll(',', ''));
    if (saleContent != null) {
      if (saleContent.salesRate <= 0 && saleContent.salesAmount > 0) {
        resultPrice = resultPrice - saleContent.salesAmount;
      } else if (saleContent.salesRate > 0 && saleContent.salesAmount <= 0) {
        resultPrice = resultPrice * (100 - saleContent.salesRate) / 100;
      }
    }
    return NumberFormat('###,###,###,###').format(resultPrice);
  }
}
