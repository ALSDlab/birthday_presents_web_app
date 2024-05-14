import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/order_model.dart';

import '../../domain/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 주문번호로 데이터 가져오기
  @override
  Future<List<OrderModel>> getFirebaseOrdersByOrderNo(
      String orderNumber) async {
    QuerySnapshot querySnapshot = await _firestore.collection('orders').get();

    List<OrderModel> data = [];
    for (var document in querySnapshot.docs) {
      data.add(OrderModel.fromJson(document.data() as Map<String, dynamic>));
    }
    return data.where((e) => e.orderId == orderNumber).toList();
  }

  // 유저아이디로 데이터 가져오기
  @override
  Future<List<OrderModel>> getFirebaseOrderByUserId(String userId) async {
    QuerySnapshot querySnapshot = await _firestore.collection('orders').get();

    List<OrderModel> data = [];
    for (var document in querySnapshot.docs) {
      data.add(OrderModel.fromJson(document.data() as Map<String, dynamic>));
    }
    return data.where((e) => e.ordererId == userId).toList();
  }
}
