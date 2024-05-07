import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/view/page/pay_page/pay_address_widget.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../styles/app_text_colors.dart';
import '../order_page/for_order_list_widget.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key, required this.forOrderItems});

  final List<OrderModel> forOrderItems;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool finalConfirmNeed = false;
  bool finalConfirmDemand = false;

  @override
  void initState() {
    Future.microtask(() {
      final payViewModel = context.read<PayPageViewModel>();

      payViewModel.init(widget.forOrderItems.first.orderId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PayPageViewModel>();
    final state = viewModel.state;
    return Scaffold(
      body: SafeArea(
        child: (state.isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '주문 확인',
                          style: TextStyle(fontFamily: 'Jalnan', fontSize: 20),
                        ),
                        Text(''),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        children: [
                          const Text(
                            '배송지 정보',
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: PayAddressWidget(
                                orderFirstItem: state.orderItems.first),
                          ),
                          const Divider(),
                          const Text(
                            '주문 상품',
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.orderItems.length,
                              itemBuilder: (context, index) {
                                final forOrderItem = state.orderItems[index];
                                return ForOrderListWidget(
                                  orderItem: forOrderItem, forConfirm: true,
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          Visibility(
                            visible: ((state.orderItems.isNotEmpty) &&
                                (state.orderItems[0].payAndStatus! < 1)),
                            // -1: 결제실패, 0: 결제전, 1: 결제완료, 2: 결제취소, 3: 배송중, 4: 배송완료
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '청약의사 재확인',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(''),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: ((state.orderItems.isNotEmpty) &&
                                (state.orderItems[0].payAndStatus! < 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: finalConfirmNeed,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        finalConfirmNeed = newValue!;
                                      });
                                    },
                                    activeColor: Colors.green,
                                    checkColor: Colors.white,
                                  ),
                                  const Text(
                                    '(필수) 구매하실 상품의 모든 정보를 확인하였으며,\n 구매진행에 동의합니다.',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (finalConfirmDemand == true),
                      child: const Text('(필수) 청약의사 재확인을 동의하셔야 주문이 진행됩니다.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                            child: const Text('취소'),
                          ),
                          TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.mainButton)),
                            onPressed: () {
                              if (finalConfirmNeed == false) {
                                setState(() {
                                  finalConfirmDemand = true;
                                });
                              } else {
                                viewModel.bootpayPayment(
                                    context, state.orderItems);
                              }
                            },
                            child: const Text('다음'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
