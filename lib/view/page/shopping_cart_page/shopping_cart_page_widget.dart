import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:myk_market_app/view/widgets/two_answer_dialog.dart';
import 'package:provider/provider.dart';

import '../../../data/model/sales_model.dart';
import '../../../utils/image_load_widget.dart';
import '../../../utils/marketing_expression.dart';

class ShoppingCartPageWidget extends StatefulWidget {
  final ShoppingProductForCart shoppingProductForCart;
  static List<ShoppingProductForCart> checkedList = [];
  final Future<void> Function(ShoppingProductForCart) removeFromCartList;
  final bool Function(int) navSetState;
  SalesModel? salesContent;

  ShoppingCartPageWidget(
      {super.key,
      required this.shoppingProductForCart,
      required this.removeFromCartList,
      required this.navSetState,
      this.salesContent});

  @override
  State<ShoppingCartPageWidget> createState() => _ShoppingCartPageWidgetState();
}

class _ShoppingCartPageWidgetState extends State<ShoppingCartPageWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShoppingCartViewModel>();
    final state = viewModel.state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget.shoppingProductForCart.isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  // widget.shoppingProductForCart.isChecked = newValue!;
                  viewModel.editShoppingCartList(state.cartList,
                      widget.shoppingProductForCart, 'payOrNot', newValue);
                });
                // if (widget.shoppingProductForCart.isChecked == true) {
                //   ShoppingCartPageWidget.checkedList
                //       .add(widget.shoppingProductForCart);
                // } else {
                //   ShoppingCartPageWidget.checkedList
                //       .remove(widget.shoppingProductForCart);
                // }
              },
              activeColor: const Color(0xFF2F362F),
              checkColor: Colors.white,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => TwoAnswerDialog(
                            title: '상품을 삭제하시겠습니까?',
                            firstButton: '아니요',
                            secondButton: '예',
                            imagePath: 'assets/gifs/two_answer_dialog.gif',
                            onFirstTap: () {
                              Navigator.pop(context);
                            },
                            onSecondTap: () async {
                              await widget.removeFromCartList(
                                  widget.shoppingProductForCart);
                              final newBadgeCount =
                                  await viewModel.getCartList();
                              widget.navSetState(newBadgeCount);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                          ));
                },
                icon: const Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width >= 1200)
              ? 1200
              : MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ImageLoadWidget(
                        width: ((MediaQuery.of(context).size.width >= 1200)
                                ? 1200
                                : MediaQuery.of(context).size.width) *
                            0.32,
                        height: ((MediaQuery.of(context).size.width >= 1200)
                                ? 1200
                                : MediaQuery.of(context).size.width) *
                            0.25,
                        imageUrl:
                            widget.shoppingProductForCart.representativeImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    MarketingExpression(
                        visible: (widget.shoppingProductForCart.salesId >= 0),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10)),
                        child: (widget.shoppingProductForCart.salesId == 0)
                            ? Image.asset(
                                'assets/gifs/hot_expression.gif',
                                width: (kIsWeb) ? 60 : 30,
                                height: (kIsWeb) ? 60 : 30,
                                fit: BoxFit.cover,
                              )
                            :
                            // (0 < product.salesId && product.salesId <= 100) ?
                            Text(
                                (widget.salesContent!.salesAmount > 0 &&
                                        widget.salesContent!.salesRate <= 0)
                                    ? ' ${widget.salesContent!.salesAmount}원 할인'
                                    : ' ${widget.salesContent!.salesRate}% 세일 ',
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    backgroundColor: Color(0xffb158ff)),
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
                        //         width: (kIsWeb) ? 60 : 30,
                        //         height: (kIsWeb) ? 60 : 30,
                        //         fit: BoxFit.cover,
                        //       )
                        //     ],
                        //   )
                        )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.shoppingProductForCart.orderProductName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '주문수량: ${widget.shoppingProductForCart.count}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.zero),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                                onTap: () {
                                  // viewModel.minusToShoppingCartList(
                                  //     widget.shoppingProductForCart, context);
                                  viewModel.editShoppingCartList(
                                      state.cartList,
                                      widget.shoppingProductForCart,
                                      'minus',
                                      null);
                                  setState(() {});
                                },
                                child: const Icon(Icons.remove)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child:
                                Text('${widget.shoppingProductForCart.count}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                                onTap: () {
                                  // viewModel.addToShoppingCartList(
                                  //     widget.shoppingProductForCart, context);
                                  viewModel.editShoppingCartList(
                                      state.cartList,
                                      widget.shoppingProductForCart,
                                      'plus',
                                      null);
                                  setState(() {});
                                },
                                child: const Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '${NumberFormat('###,###,###,###').format(widget.shoppingProductForCart.count * int.parse((widget.salesContent != null) ? deCalculatedPrice(widget.shoppingProductForCart.price.replaceAll(',', ''), widget.salesContent!) : widget.shoppingProductForCart.price.replaceAll(',', '')))}원',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  String deCalculatedPrice(String originalPrice, SalesModel saleContent) {
    num resultPrice = int.parse(originalPrice);
    if (saleContent.salesRate <= 0 && saleContent.salesAmount > 0) {
      resultPrice = int.parse(originalPrice) - saleContent.salesAmount;
    } else if (saleContent.salesRate > 0 && saleContent.salesAmount <= 0) {
      resultPrice =
          int.parse(originalPrice) * (100 - saleContent.salesRate) / 100;
    }
    return resultPrice.toString();
  }
}
