import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/order_model.dart';

class ForOrderListWidget extends StatelessWidget {
  const ForOrderListWidget(
      {super.key, required this.orderItem, this.forConfirm = false});

  final OrderModel orderItem;
  final bool forConfirm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                fit:BoxFit.cover,
                  image: CachedNetworkImageProvider(
                orderItem.representativeImage,
              )),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderItem.orderProductName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '주문수량: ${orderItem.count}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${NumberFormat('###,###,###,###').format(int.parse(orderItem.price.replaceAll(',', '')) * orderItem.count)}원',
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ],
          )
        ],
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
    '($result)',
    style: TextStyle(color: color),
  );
}
