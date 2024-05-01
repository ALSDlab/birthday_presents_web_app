import 'package:myk_market_app/data/model/order_model.dart';

abstract interface class OrderRepository {
  Future<List<OrderModel>> getFirebaseMyOrders(String orderNumber);
}
