import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/shopping_cart_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/simple_logger.dart';

class ProductDetailPageViewModel extends ChangeNotifier {
  ProductDetailPageState _state = const ProductDetailPageState();

  ProductDetailPageState get state => _state;

  Future<void> getBadgeCount() async {
    _state = state.copyWith(forBadgeList: await getShoppingCartList());
    notifyListeners();
  }

  int purchaseCount = 1;
  int cartCount = 1;

  void plusPurchaseCount() {
    purchaseCount++;
    notifyListeners();
  }

  void minusPurchaseCount() {
    if (purchaseCount > 1) purchaseCount--;
    notifyListeners();
  }

  void plusCartCount() {
    cartCount++;
    notifyListeners();
  }

  void minusCartCount() {
    if (cartCount > 1) cartCount--;
    notifyListeners();
  }

  String formatKoreanNumber(int number) {
    String formattedNumber = number.toString();
    if (formattedNumber.length <= 3) {
      return formattedNumber;
    }
    int commaIndex = formattedNumber.length % 3;
    if (commaIndex == 0) {
      commaIndex = 3;
    }
    StringBuffer buffer = StringBuffer();
    buffer.write(formattedNumber.substring(0, commaIndex));
    for (int i = commaIndex; i < formattedNumber.length; i += 3) {
      buffer.write(',');
      buffer.write(formattedNumber.substring(i, i + 3));
    }
    return buffer.toString();
  }

  // 주문번호 생성하는 매서드 (연월일(YYMMDD) + 모든 영문자 4자리 형식)
  String generateLicensePlate(String currentDate) {
    // 4자리의 랜덤한 영문자 생성
    String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String randomLetters = '';
    Random random = Random();
    for (int i = 0; i < 4; i++) {
      randomLetters += letters[random.nextInt(26)];
    }

    // 주문번호 조합
    String licensePlate = currentDate + randomLetters;
    return licensePlate;
  }

  // shared_preferences를 이용하여 장바구니에 담는 기능 구현 (장바구니에서 삭제하는 기능 포함)
  static const String _key = 'shoppingCartList';

  // 장바구니 불러오는 기능
  Future<List<ShoppingProductForCart>> getShoppingCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedProducts = prefs.getString(_key);

    if (selectedProducts != null) {
      // 저장된 데이터가 있다면 JSON을 파싱하여 리스트로 변환
      final jsonList = jsonDecode(selectedProducts) as List<dynamic>;
      return jsonList.map((e) => ShoppingProductForCart.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // 장바구니에 담는 메서드
  Future<void> addToShoppingCartList(
      ShoppingProductForCart item, BuildContext context) async {
    List<ShoppingProductForCart> currentList = await getShoppingCartList();

    // 중복 체크
    var index =
        currentList.indexWhere((product) => product.orderId == item.orderId);
    if (index == -1) {
      currentList.add(item);
    } else {
      currentList[index].count += item.count;
    }
    // 다시 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    prefs.setString(_key, jsonString);

    // 스낵바로 표시
    if (context.mounted) {
      cartAddSnackBar(context);
    }
  }

  // 스낵바 구현 매서드
  void cartAddSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('장바구니에 담겼습니다.', style: TextStyle(fontFamily: 'Jalnan')),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // 장바구니에서 제거하는 기능
  Future<void> removeFromCartList(ShoppingProductForCart item) async {
    try {
      List<ShoppingProductForCart> currentList = await getShoppingCartList();
      currentList.remove(item);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString =
          jsonEncode(currentList.map((e) => e.toJson()).toList());
      prefs.setString(_key, jsonString);
    } catch (e) {
      logger.info('Error during removal: $e');
    }
    notifyListeners();
  }
}
