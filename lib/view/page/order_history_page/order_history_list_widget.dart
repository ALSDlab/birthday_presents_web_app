import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import 'order_history_page_view_model.dart';

class OrderHistoryListWidget extends StatelessWidget {
  const OrderHistoryListWidget(
      {super.key, required this.orderItem, required this.hideNavBar});

  final List<OrderModel> orderItem;
  final bool Function(bool) hideNavBar;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderHistoryPageViewModel>();
    final state = viewModel.state;
    return GestureDetector(
      onTap: () async {
        // String currentUser = FirebaseAuth
        //     .instance.currentUser!.email!
        //     .replaceAll('@gmail.com', '');
        // final myOrderItems =
        //     await viewModel.getMyOrderData(currentUser);
        if (context.mounted) {
          GoRouter.of(context).push(
              '/shopping_cart_page/fill_order_page/pay_page',
              extra: {'orderModelList': orderItem, 'hideNavBar': hideNavBar});
          hideNavBar(true);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (orderItem.length > 1)
                      ? Text(
                          '${orderItem.first.orderProductName} 외 ${orderItem.length - 1}건',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      : Text(
                          orderItem.first.orderProductName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                  Text(
                    '주문번호: ${orderItem.first.orderId}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '${NumberFormat('###,###,###,###').format(orderItem.fold(0, (p, e) => p + e.payAmount!))} 원',
                        style: const TextStyle(
                            color: Color(0xFF019934),
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                      payStatusWidget(orderItem.first.payAndStatus!),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    DateFormat('yy년 M월 dd일').format(
                        DateTime.parse('20${orderItem.first.orderedDate!}')),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () async {
                        await viewModel.postDeleted(orderItem);
                      },
                      child: Text('삭제하기'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget payStatusWidget(int statusValue) {
  String result = '';
  Color color = Colors.transparent;
  switch (statusValue) {
    case -1:
      result = '결제실패';
      color = Colors.red;
      break;
    case 0:
      result = '결제전';
      color = Colors.red;
      break;
    case 1:
      result = '결제완료';
      color = Colors.blue;
      break;
    case 2:
      result = '결제취소';
      color = Colors.red;
      break;
    case 3:
      result = '배송중';
      color = Colors.orange;
      break;
    case 4:
      result = '배송완료';
      color = Colors.blue;
      break;
  }

  return Text(
    ' ($result)',
    style: TextStyle(color: color),
  );
}
