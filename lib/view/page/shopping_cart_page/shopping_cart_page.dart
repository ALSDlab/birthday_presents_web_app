import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_page_widget.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage(
      {super.key, required this.navSetState, required this.hideNavBar});

  final bool Function(int) navSetState;
  final bool Function(bool) hideNavBar;

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool isAllChecked = false;
  bool resetShoppingCart = false;

  // @override
  // void initState() {
  //   ShoppingCartPageWidget.checkedList = [];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShoppingCartViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '장바구니',
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
              child: state.isLoading
                  ? Center(child: GifProgressBar())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '주문 상품',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
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
                                      // item.isChecked =
                                      //     newValue; // isChecked 변수의 값을 반대로 변경
                                      viewModel.editShoppingCartList(
                                          state.cartList,
                                          item,
                                          'payOrNot',
                                          newValue);
                                    }
                                  });
                                  // ShoppingCartPageWidget.checkedList.addAll(state
                                  //     .cartList
                                  //     .where((model) => model.isChecked == true));
                                  // ShoppingCartPageWidget.checkedList.removeWhere(
                                  //     (model) => model.isChecked == false);
                                },
                                activeColor: const Color(0xFF2F362F),
                                checkColor: Colors.white,
                              ),
                              const Text('전체 선택'),
                            ],
                          ),
                          const Divider(),
                          state.cartList.isEmpty
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('장바구니가 비었습니다.'),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))),
                                          onPressed: () {
                                            context.go('/product_page', extra: {
                                              'navSetState': widget.navSetState,
                                              'hideNavBar': widget.hideNavBar
                                            });
                                          },
                                          child: const Text(
                                            '상품 담으러 가기',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ShoppingCartPageWidget(
                                                shoppingProductForCart:
                                                    state.cartList[index],
                                                removeFromCartList: viewModel
                                                    .removeFromCartList,
                                                navSetState: widget.navSetState,
                                              );
                                            },
                                            itemCount: state.cartList.length,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Expanded(child: Container()),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final List<
                                                            ShoppingProductForCart>
                                                        reloadedList =
                                                        await viewModel
                                                            .updateCartList(
                                                                state.cartList);
                                                    final List<OrderModel>
                                                        orderItemList =
                                                        await viewModel.sendCart(
                                                            reloadedList
                                                                .where((e) =>
                                                                    e.isChecked ==
                                                                    true)
                                                                .toList());
                                                    if (reloadedList
                                                        .where((e) =>
                                                            e.isChecked == true)
                                                        .toList()
                                                        .isEmpty) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return OneAnswerDialog(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                title:
                                                                    '선택된 상품이 없습니다.',
                                                                subtitle:
                                                                    '상품을 선택해 주세요',
                                                                firstButton:
                                                                    '확인',
                                                                imagePath:
                                                                    'assets/gifs/alert.gif');
                                                          });
                                                    } else {
                                                      // ShoppingCartPageWidget.checkedList = [];
                                                      final result = await GoRouter
                                                              .of(context)
                                                          .push(
                                                              '/shopping_cart_page/fill_order_page',
                                                              extra: {
                                                            'orderModelList':
                                                                orderItemList,
                                                            'navSetState': widget
                                                                .navSetState,
                                                            'hideNavBar': widget
                                                                .hideNavBar
                                                          });
                                                      if (result == true) {
                                                        viewModel.getCartList();
                                                      }
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF2F362F),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)))),
                                                  child: const Text(
                                                    '주문하기',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  // style: ButtonStyle(
                                                  //   backgroundColor: MaterialStateProperty.all(
                                                  //     const Color(0xFF2F362F),
                                                  //   ),
                                                  // ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
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
