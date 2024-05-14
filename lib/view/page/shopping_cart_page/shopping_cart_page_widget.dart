import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/image_load_widget.dart';

class ShoppingCartPageWidget extends StatefulWidget {
  final ShoppingProductForCart shoppingProductForCart;
  static List<ShoppingProductForCart> checkedList = [];
  final Future<void> Function(ShoppingProductForCart) removeFromCartList;
  final bool Function(int) navSetState;

  const ShoppingCartPageWidget({
    super.key,
    required this.shoppingProductForCart,
    required this.removeFromCartList,
    required this.navSetState,
  });

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
                  viewModel.editShoppingCartList(state.cartList, widget.shoppingProductForCart, 'payOrNot', newValue);
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
                      builder: (context) => AlertDialog(
                            content: const Text('상품을 삭제하시겠습니까?'),
                            actions: [
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('아니요')),
                              OutlinedButton(
                                  onPressed: () async {
                                    await widget.removeFromCartList(
                                        widget.shoppingProductForCart);
                                    final newBadgeCount =
                                        await viewModel.getCartList();
                                    widget.navSetState(newBadgeCount);
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('예'))
                            ],
                          ));
                },
                icon: const Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageLoadWidget(
                      width: MediaQuery.of(context).size.width * 0.32,
                      widthHeightRatio: 0.65,
                      imageUrl:
                          widget.shoppingProductForCart.representativeImage),
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
                                  viewModel.editShoppingCartList(state.cartList, widget.shoppingProductForCart, 'minus', null);
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
                                  viewModel.editShoppingCartList(state.cartList, widget.shoppingProductForCart, 'plus', null);
                                  setState(() {});
                                },
                                child: const Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '${NumberFormat('###,###,###,###').format(int.parse(widget.shoppingProductForCart.price.replaceAll(',', '')) * widget.shoppingProductForCart.count)}원',
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
}
