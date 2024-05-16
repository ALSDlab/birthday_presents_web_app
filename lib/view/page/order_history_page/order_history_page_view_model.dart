import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<List<OrderModel>> newSortedList = [];

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
      final List<OrderModel> mySortedOrder =
          myOrder.where((e) => e.deletedDate == '').toList();

      // 주문번호별로 구분 ([[주문번호_1],[주문번호_2],[주문번호_3]] 형태로 만들기)
      if (mySortedOrder.isNotEmpty) {
        List<OrderModel> myOrderByOrderNo = [];
        if (mySortedOrder.length == 1) {
          myOrderByOrderNo = mySortedOrder;
        } else {
          for (int i = 0; i < mySortedOrder.length - 1; i++) {
            myOrderByOrderNo.add(mySortedOrder[i]);
            if (mySortedOrder[i].orderId != mySortedOrder[i + 1].orderId) {
              myTotalOrders.add(List.from(myOrderByOrderNo));
              myOrderByOrderNo = [];
            }
          }
          if (mySortedOrder[mySortedOrder.length - 1].orderId ==
              mySortedOrder[mySortedOrder.length - 2].orderId) {
            myOrderByOrderNo.add(mySortedOrder[mySortedOrder.length - 1]);
          } else {
            myOrderByOrderNo = [mySortedOrder[mySortedOrder.length - 1]];
          }
        }
        myTotalOrders.add(List.from(myOrderByOrderNo));
      }

      // 주문일자 순으로 정렬 (역순도 가능)
      _state = state.copyWith(isAscending: !state.isAscending);
      final List<List<OrderModel>> newSortedList = myTotalOrders
        ..sort((a, b) => a.first.orderedDate!.compareTo(b.first.orderedDate!));

      if (!state.isAscending) {
        _state =
            state.copyWith(orderHistoryList: newSortedList.reversed.toList());
      } else {
        _state = state.copyWith(orderHistoryList: newSortedList);
      }
      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error getting data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  // 주문내역 삭제하기
  Future<void> postDeleted(List<OrderModel> orderItem) async {
    try {
      _state = state.copyWith(isLoading: true);
      notifyListeners();
      for (var item in orderItem) {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(item.orderId + item.productId)
            .update(
                {'deletedDate': DateTime.now().toString().substring(0, 21)});
      }

      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error post payInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      await getMyOrderData();
      notifyListeners();
    }
  }
}
