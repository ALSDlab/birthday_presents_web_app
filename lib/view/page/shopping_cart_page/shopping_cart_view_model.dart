import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/shopping_cart_model.dart';

class ShoppingCartViewModel extends ChangeNotifier {

List<ShoppingProductForCart> cartList = [];


ShoppingCartViewModel() {
 getShoppingCartList();
}
  // shared_preferences를 이용하여 장바구니에 담는 기능 구현 (장바구니에서 삭제하는 기능 포함)
  static const String _key = 'shoppingCartList';

  // 장바구니 불러오는 기능
  static Future<List<ShoppingProductForCart>> getShoppingCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedProducts = prefs.getString(_key);

    if (selectedProducts != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
      final jsonList = jsonDecode(selectedProducts) as List<dynamic>;
      final cartList = jsonList.map((e) => ShoppingProductForCart.fromJson(e)).toList();
      return cartList;
    } else {
      return [];
    }
  }
}