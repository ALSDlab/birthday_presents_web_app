import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/order_model.dart';

import '../../../data/model/sales_model.dart';
import '../../../utils/image_load_widget.dart';

class ForOrderListWidget extends StatelessWidget {
  ForOrderListWidget(
      {super.key,
      required this.orderItem,
      this.forConfirm = false,
      this.salesContent});

  final OrderModel orderItem;
  final bool forConfirm;
  SalesModel? salesContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageLoadWidget(
                width: ((MediaQuery.of(context).size.width >= 1200)
                        ? 1200
                        : MediaQuery.of(context).size.width) *
                    0.32,
                height: ((MediaQuery.of(context).size.width >= 1200)
                        ? 1200
                        : MediaQuery.of(context).size.width) *
                    0.25,
                imageUrl: orderItem.representativeImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.orderProductName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
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
                      '${NumberFormat('###,###,###,###').format(orderItem.count * int.parse((salesContent != null) ? deCalculatedPrice(orderItem.price.replaceAll(',', ''), salesContent!) : orderItem.price.replaceAll(',', '')))}원',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16),
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
