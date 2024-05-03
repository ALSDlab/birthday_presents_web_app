import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import '../../../data/model/shopping_cart_model.dart';

class ShoppingCartPage extends StatefulWidget {

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool _subMenu = false;


  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() async {
  //     final ShoppingCartViewModel viewModel = context.read<ShoppingCartViewModel>();
  //
  //     await viewModel.getShoppingCartList();
  //   });
  // }
  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<ShoppingCartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '민영기 염소탕',
          style: TextStyle(fontFamily: 'Jalnan', fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('주문상품'),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: _subMenu,
                        onChanged: (value) {
                          setState(() {
                            _subMenu = value!;
                          });
                        }),
                    Text('전체선택'),
                  ],
                ),
              ),
              Container(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                viewModel.cartList[0].representativeImage,
                                //widget.shoppingProductForCart.representativeImage,
                              )),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.cartList[0].orderProductName,
                            //widget.shoppingProductForCart.orderProductName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '주문수량: ${viewModel.cartList[0].count}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${NumberFormat('###,###,###,###').format(int.parse(
                                viewModel.cartList[0].price.replaceAll(',', '')) *
                                viewModel.cartList[0].count)}원',
                            style:
                            const TextStyle(fontWeight: FontWeight.w900,
                                fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Color(0xFF2F362F),
                  ),
                  onPressed: () {
                    // final createdDate = DateTime.now()
                    //     .toString()
                    //     .substring(2, 10)
                    //     .replaceAll('-', '');
                    // final OrderModel directOrderItem = OrderModel(
                    //   orderId: viewModel.generateLicensePlate(createdDate),
                    //   orderProductName: widget.product.title,
                    //   representativeImage: widget.product.representativeImage,
                    //   price: widget.product.price,
                    //   count: viewModel.purchaseCount,
                    //   orderedDate: createdDate,
                    // );
                    // context.push('/fill_order_page', extra: [directOrderItem]);
                  },
                  child: Text(
                    '구매하기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
