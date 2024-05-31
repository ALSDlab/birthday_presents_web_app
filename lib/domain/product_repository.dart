import 'package:myk_market_app/data/model/product_model.dart';

import '../data/model/sales_model.dart';

abstract interface class ProductRepository {
  Future<List<ProductModel>> getFirebaseProduct();

  Future<SalesModel?> getSales(int saleId);
}