import 'package:myk_market_app/data/model/store_model.dart';

abstract interface class StoreRepository {
  Future<List<Store>> getFirebaseStore();
}