import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:myk_market_app/view/page/navigation_page/scaffold_with_nav_bar_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/shopping_cart_model.dart';
import '../../../utils/simple_logger.dart';

class ScaffoldWithNavBarViewModel extends ChangeNotifier {

  ScaffoldWithNavBarViewModel(){
    getBadgeCount();
  }

  ScaffoldWithNavBarState _state = const ScaffoldWithNavBarState();

  ScaffoldWithNavBarState get state => _state;

  Future<void> getBadgeCount() async {
    final List<ShoppingProductForCart> result = await getShoppingCartList();
    logger.info(result);
    _state = state.copyWith(forBadgeList: result);
    notifyListeners();
  }

  // 장바구니 불러오는 기능
  Future<List<ShoppingProductForCart>> getShoppingCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedProducts = prefs.getString('shoppingCartList');

    if (selectedProducts != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
      final jsonList = jsonDecode(selectedProducts) as List<dynamic>;
      return jsonList.map((e) => ShoppingProductForCart.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}