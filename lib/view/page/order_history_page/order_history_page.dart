import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_history_list_widget.dart';
import 'order_history_page_view_model.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderHistoryPageViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F362F),
        title: const Text(
          '주문 내역',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Container(
          color: const Color(0xFFFFF8E7),
          child: (state.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (state.orderHistoryList.isEmpty)
                  ? const Center(
                      child: Text('주문하신 내역이 없습니다.'),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.orderHistoryList.length,
                      itemBuilder: (context, index) {
                        final orderHistoryItem = state.orderHistoryList[index];
                        return OrderHistoryListWidget(
                          orderItem: orderHistoryItem,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
