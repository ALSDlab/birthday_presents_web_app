import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/order_model.dart';

class PayAddressWidget extends StatelessWidget {
  const PayAddressWidget({super.key, required this.orderFirstItem});

  final OrderModel orderFirstItem;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ((MediaQuery.of(context).size.width >= 1200) ? 1200 : MediaQuery.of(context).size.width) * 0.25,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('주 문 자 명 :'),
                Text('연   락   처 :'),
                Text('주         소 :'),
              ],
            ),
          ),
          SizedBox(
            width: ((MediaQuery.of(context).size.width >= 1200) ? 1200 : MediaQuery.of(context).size.width) * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(orderFirstItem.ordererName!),
                Text(orderFirstItem.ordererPhoneNo!),
                Text(
                    '우) ${orderFirstItem.ordererPostcode}, ${orderFirstItem.ordererAddress!} ${orderFirstItem.ordererAddressDetail!}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
