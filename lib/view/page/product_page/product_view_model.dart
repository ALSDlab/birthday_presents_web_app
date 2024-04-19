import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/repository/product_repository_impl.dart';
import 'package:myk_market_app/view/page/product_page/product_state.dart';

class ProductViewModel extends ChangeNotifier {
  ProductRepositoryImpl repository = ProductRepositoryImpl();
  ProductState _state = const ProductState();

  ProductState get state => _state;

  void getProducts() async {
    _state = state.copyWith(products: await repository.getFirebaseProduct());
    // return await repository.getFirebaseProduct();
    notifyListeners();
    print(state.products);
  }
}
