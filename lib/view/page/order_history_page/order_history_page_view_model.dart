import 'package:flutter/widgets.dart';
import 'package:myk_market_app/data/model/order_model.dart';

import '../../../domain/order_repository.dart';

class OrderHistoryPageViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;

  OrderHistoryPageViewModel({
    required this.orderRepository,
  });

  Future<List<OrderModel>> getMyOrderData(String userId) async {
    List<OrderModel> myOrder = [];
    try {
      myOrder = await orderRepository.getFirebaseOrderByUserId(userId);
      notifyListeners();
      return myOrder;
    } catch (error) {
      // 에러 처리
      debugPrint('Error getting data: $error');
      return myOrder;
    }
  }
}
