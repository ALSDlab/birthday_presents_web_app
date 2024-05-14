import 'package:myk_market_app/data/model/order_model.dart';

abstract interface class OrderRepository {
  Future<List<OrderModel>> getFirebaseOrdersByOrderNo(String orderNumber);

  Future<List<OrderModel>> getFirebaseOrderByUserId(String userId);
}
