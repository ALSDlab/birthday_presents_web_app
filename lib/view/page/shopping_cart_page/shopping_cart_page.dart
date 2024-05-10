import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_page_widget.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool isAllChecked = false;

  // @override
  // void initState() {
  //   Future.microtask(() async {
  //     final ShoppingCartViewModel viewModel =
  //         context.read<ShoppingCartViewModel>();
  //     await viewModel.getCartList();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShoppingCartViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const CircularProgressIndicator()
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '주문 상품',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xFFcccccc),
                  thickness: 8,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isAllChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isAllChecked = newValue!;
                          for (var item in state.cartList) {
                            item.isChecked =
                                newValue; // isChecked 변수의 값을 반대로 변경
                          }
                        });
                      },
                      activeColor: const Color(0xFF2F362F),
                      checkColor: Colors.white,
                    ),
                    const Text('전체 선택'),
                  ],
                ),
                const Divider(),
                state.cartList.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          children: [
                            Text('장바구니가 비었습니다.'),
                            OutlinedButton(
                              onPressed: () {
                                context.go('/product_page');
                              },
                              child: Text('상품 담으러 가기'),
                            ),
                          ],
                        ),
                    )
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ShoppingCartPageWidget(
                              shoppingProductForCart: state.cartList[index],
                              removeFromCartList: () {
                                viewModel
                                    .removeFromCartList(state.cartList[index]);
                              },
                            );
                          },
                          itemCount: state.cartList.length,
                        ),
                      )
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            final List<OrderModel> orderItemList =
                await viewModel.sendCart(ShoppingCartPageWidget.checkedList);
            if (ShoppingCartPageWidget.checkedList.isEmpty) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('알림'),
                      content: Text('선택된 상품이 없습니다. 상품을 선택해 주세요'),
                    );
                  });
            } else {
              GoRouter.of(context).go('/shopping_cart_page/fill_order_page',
                  extra: orderItemList);
            }
          },
          child: Text(
            '주문하기',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFF2F362F),
            ),
          ),
        ),
      ),
    );
  }
}
