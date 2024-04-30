import 'package:myk_market_app/data/model/product_model.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getFirebaseProduct();
}