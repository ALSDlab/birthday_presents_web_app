import 'package:flutter/material.dart';
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
        title: Text('장바구니'),
        centerTitle: true,
      ),
      body: state.isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '주문 상품',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ),
                Divider(
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
                          // isTermsNConditionsChecked =
                          //     newValue;
                          // isPersonalInfoChecked =
                          //     newValue;
                          // isPersonalInfoForDeliverChecked =
                          //     newValue;
                        });
                      },
                      activeColor: const Color(0xFF2F362F),
                      checkColor: Colors.white,
                    ),
                    const Text('전체 선택'),
                  ],
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ShoppingCartPageWidget(
                        shoppingProductForCart: state.cartList[index],
                      );
                    },
                    itemCount: state.cartList.length,
                  ),
                )
              ],
            ),
    );
  }
}
