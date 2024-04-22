import 'package:flutter/material.dart';
import 'package:myk_market_app/data/repository/product_repository_impl.dart';
import 'package:myk_market_app/view/page/product_page/product_state.dart';

class ProductViewModel extends ChangeNotifier {
  ProductRepositoryImpl repository = ProductRepositoryImpl();
  ProductState _state = const ProductState();

  ProductState get state => _state;

  Future<void> getProducts() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    _state = state.copyWith(
        products: await repository.getFirebaseProduct(), isLoading: false);
    notifyListeners();

  }
}
