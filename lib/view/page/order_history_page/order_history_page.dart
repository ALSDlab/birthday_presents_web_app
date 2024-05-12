import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_history_page_view_model.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderHistoryPageViewModel>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2F362F),
          title: const Text(
            '주문 확인',
            style: TextStyle(
                fontFamily: 'Jalnan', fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('주문하신 내역이 없습니다.'),
        ));
  }
}
