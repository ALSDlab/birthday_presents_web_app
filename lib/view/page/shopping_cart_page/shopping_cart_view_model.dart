import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/shopping_cart_model.dart';

class ShoppingCartViewModel extends ChangeNotifier {
  ShoppingCartState _state = ShoppingCartState();

  ShoppingCartState get state => _state;

  // List<ShoppingProductForCart> cartList = [];
  //
  ShoppingCartViewModel() {
    getCartList();
  }

  // bool _disposed = false;
  //
  // @override
  // void dispose() {
  //   _disposed = true;
  //   super.dispose();
  // }
  //
  // @override
  // notifyListeners() {
  //   if (!_disposed) {
  //     super.notifyListeners();
  //   }
  // }

  Future<void> getCartList() async {
    _state = state.copyWith(cartList: await getShoppingCartList());
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(isLoading: false);
    notifyListeners();
    print(state.cartList);
  }

  // shared_preferences를 이용하여 장바구니에 담는 기능 구현 (장바구니에서 삭제하는 기능 포함)

  // 장바구니 불러오는 기능
  Future<List<ShoppingProductForCart>> getShoppingCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedProducts = prefs.getString('shoppingCartList');

    if (selectedProducts != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
      final jsonList = jsonDecode(selectedProducts) as List<dynamic>;
      final cartList =
          jsonList.map((e) => ShoppingProductForCart.fromJson(e)).toList();
      return cartList;
    } else {
      return [];
    }
  }
}