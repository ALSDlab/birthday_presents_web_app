import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/order_model.dart';

class PayAddressWidget extends StatelessWidget {
  const PayAddressWidget({super.key, required this.orderFirstItem});

  final OrderModel orderFirstItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
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
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderFirstItem.ordererName!),
              Text(orderFirstItem.ordererPhoneNo!),
              Text(
                  '우)${orderFirstItem.ordererPostcode}, ${orderFirstItem.ordererAddress!} ${orderFirstItem.ordererAddressDetail!}'),
            ],
          ),
        )
      ],
    );
  }
}
