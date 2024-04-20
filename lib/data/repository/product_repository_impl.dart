import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/domain/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getFirebaseProduct() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('product')
        .orderBy('title', descending: false)
        .get();

    List<Product> data = [];
    for (var document in querySnapshot.docs) {
      data.add(Product.fromJson(document.data() as Map<String, dynamic>));
    }
    return data;
  }
}
