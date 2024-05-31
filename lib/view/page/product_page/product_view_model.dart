import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/model/sales_model.dart';
import 'package:myk_market_app/data/repository/product_repository_impl.dart';
import 'package:myk_market_app/view/page/product_page/product_state.dart';

class ProductViewModel extends ChangeNotifier {
  ProductRepositoryImpl repository = ProductRepositoryImpl();
  List<ProductModel> products = [];
  List<ProductModel> filteredData = [];

  ProductState _state = const ProductState();

  ProductState get state => _state;

  Future<void> getProducts() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    products = await repository.getFirebaseProduct();
    filteredData = products;
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  void onChanged(value) {
    products =
        filteredData.where((element) => element.title.contains(value)).toList();
    notifyListeners();
  }

  Future<SalesModel?> getSalesContent(int saleId) async {
    SalesModel? salesContent = await repository.getSales(saleId);
    return salesContent;
  }
}
