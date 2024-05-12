import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/order_model.dart';

import '../main_page/image_load_widget.dart';

class ForOrderListWidget extends StatelessWidget {
  const ForOrderListWidget(
      {super.key, required this.orderItem, this.forConfirm = false});

  final OrderModel orderItem;
  final bool forConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
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
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageLoadWidget(
                width: MediaQuery.of(context).size.width * 0.32,
                widthHeightRatio: 0.65,
                imageUrl: orderItem.representativeImage,
                          ),
            ),

            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.orderProductName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '주문수량: ${orderItem.count}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${NumberFormat('###,###,###,###').format(int.parse(orderItem.price.replaceAll(',', '')) * orderItem.count)} 원',
                      style:
                          const TextStyle(color: Color(0xFF019934), fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    payStatusWidget(orderItem.payAndStatus!),
                  ],
                ),
              ],
            )
          ],
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
