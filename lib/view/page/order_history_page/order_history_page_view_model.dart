import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:myk_market_app/data/model/order_model.dart';

import '../../../domain/order_repository.dart';
import '../../../utils/simple_logger.dart';
import 'order_history_page_state.dart';

class OrderHistoryPageViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;

  OrderHistoryPageViewModel({
    required this.orderRepository,
  }) {
    getMyOrderData();
  }

  OrderHistoryPageState _state = const OrderHistoryPageState();

  OrderHistoryPageState get state => _state;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  // 유저 주문내역 불러오기
  Future<void> getMyOrderData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    List<List<OrderModel>> myTotalOrders = [];
    try {
      List<OrderModel> myOrder = [];
      String currentUser = FirebaseAuth.instance.currentUser!.email!
          .replaceAll('@gmail.com', '');
      myOrder = await orderRepository.getFirebaseOrderByUserId(currentUser);
      myOrder.sort((a, b) => b.orderId.compareTo(a.orderId));

      // 주문번호별로 구분 ([[주문번호_1],[주문번호_2],[주문번호_3]] 형태로 만들기)
      List<OrderModel> myOrderByOrderNo = [];
      for (int i = 0; i < myOrder.length - 1; i++) {
        myOrderByOrderNo.add(myOrder[i]);
        if (myOrder[i].orderId != myOrder[i + 1].orderId) {
          myTotalOrders.add(List.from(myOrderByOrderNo));
          myOrderByOrderNo = [];
        }
      }
      if (myOrder[myOrder.length - 1] == myOrder[myOrder.length - 2]) {
        myOrderByOrderNo.add(myOrder[myOrder.length - 1]);
      } else {
        myOrderByOrderNo = [myOrder[myOrder.length - 1]];
      }
      myTotalOrders.add(List.from(myOrderByOrderNo));

      _state = state.copyWith(orderHistoryList: myTotalOrders);
      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error getting data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
