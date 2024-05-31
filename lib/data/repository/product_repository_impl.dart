import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/model/sales_model.dart';
import 'package:myk_market_app/domain/product_repository.dart';

import '../../utils/simple_logger.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getFirebaseProduct() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('product')
        .orderBy('title', descending: false)
        .get();

    List<ProductModel> data = [];
    for (var document in querySnapshot.docs) {
      data.add(ProductModel.fromJson(document.data() as Map<String, dynamic>));
    }
    return data;
  }

  @override
  Future<SalesModel?> getSales(int salesId) async {
    try {
      // Firebase Firestore에서 데이터 읽어오기
      var querySnapshot = await _firestore
          .collection('sales')
          .where('salesId', isEqualTo: salesId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 첫 번째 문서를 가져와서 CouponsModel로 변환
        var doc = querySnapshot.docs.first;

        return SalesModel.fromJson(doc.data());
      } else {
        // 세일이 없을 경우 null 반환
        return null;
      }
    } catch (e) {
      // 오류가 발생하면 null 반환하거나, 적절한 오류 처리를 합니다.
      logger.info('Error getting coupon: $e');
      return null;
    }
  }
}
