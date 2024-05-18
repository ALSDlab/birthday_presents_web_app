import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '주문 내역',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              viewModel.getMyOrderData();
            },
            icon: const Icon(BootstrapIcons.arrow_down_up),
            color: Colors.white,
          )
        ],
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
              child: (state.isLoading)
                  ? const Center(
                      child: GifProgressBar(),
                    )
                  : (state.orderHistoryList.isEmpty)
                      ? const Center(
                          child: Text('주문하신 내역이 없습니다.'),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.orderHistoryList.length,
                          itemBuilder: (context, index) {
                            final orderHistoryItem =
                                state.orderHistoryList[index];
                            return OrderHistoryListWidget(
                              orderItem: orderHistoryItem,
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
