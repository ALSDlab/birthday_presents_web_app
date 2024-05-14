import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/shopping_cart_model.dart';

class ShoppingCartViewModel extends ChangeNotifier {
  ShoppingCartState _state = const ShoppingCartState();

  ShoppingCartState get state => _state;

  ShoppingCartViewModel() {
    getCartList();
  }

  Future<int> getCartList() async {
    final resultList = await getShoppingCartList();
    _state = state.copyWith(cartList: resultList);
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(isLoading: false);
    notifyListeners();
    return resultList.length;
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

  // 장바구니 수량 편집 메서드
  void editShoppingCartList(List<ShoppingProductForCart> originalList,
      ShoppingProductForCart item, String doWhat, bool? value) {
    // 중복 체크
    var index =
        originalList.indexWhere((product) => product.orderId == item.orderId);

    switch (doWhat) {
      case 'plus':
        originalList[index].count++;
        break;
      case 'minus':
        if (originalList[index].count > 1) originalList[index].count--;
        break;
      case 'payOrNot':
        originalList[index].isChecked = value;
        break;
    }
  }

  // 리스트 update

  Future<List<ShoppingProductForCart>> updateCartList(
      List<ShoppingProductForCart> updatedList) async {
    // 저장하기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(updatedList.map((e) => e.toJson()).toList());
    prefs.setString('shoppingCartList', jsonString);

    // 다시 불러오기
    List<ShoppingProductForCart> reloadList = await getShoppingCartList();
    return reloadList;
  }

  //장바구니에 수량 + 적용시키는 기능
  Future<void> addToShoppingCartList(
      ShoppingProductForCart item, BuildContext context) async {
    List<ShoppingProductForCart> currentList = await getShoppingCartList();

    // 중복 체크
    var index =
        currentList.indexWhere((product) => product.orderId == item.orderId);

    currentList[index].count++;

    // 다시 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    prefs.setString('shoppingCartList', jsonString);
    getCartList();
  }

  //장바구니에 수량 - 적용시키는 기능
  Future<void> minusToShoppingCartList(
      ShoppingProductForCart item, BuildContext context) async {
    List<ShoppingProductForCart> currentList = await getShoppingCartList();

    // 중복 체크
    var index =
        currentList.indexWhere((product) => product.orderId == item.orderId);

    if (currentList[index].count > 1) currentList[index].count--;

    // 다시 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    prefs.setString('shoppingCartList', jsonString);
    getCartList();
  }

  //장바구니 제거하는 기능
  Future<void> removeFromCartList(ShoppingProductForCart item) async {
    try {
      List<ShoppingProductForCart> currentList = await getShoppingCartList();
      // currentList.remove(item);
      currentList.removeWhere((element) => element.orderId == item.orderId);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString =
          jsonEncode(currentList.map((e) => e.toJson()).toList());
      prefs.setString('shoppingCartList', jsonString);
    } catch (e) {
      print('Error during removal: $e');
    }
    getCartList();
  }

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

  Future<List<OrderModel>> sendCart(List<ShoppingProductForCart> list) async {
    List<OrderModel> result = [];

    final createdDate =
        DateTime.now().toString().substring(2, 10).replaceAll('-', '');

    final String newOrderId = generateLicensePlate(createdDate);

    for (int i = 0; i < list.length; i++) {
      final OrderModel directOrderItem = OrderModel(
        orderId: newOrderId,
        orderProductName: list[i].orderProductName,
        representativeImage: list[i].representativeImage,
        price: list[i].price,
        count: list[i].count,
        orderedDate: createdDate,
        payAndStatus: 0,
      );
      result.add(directOrderItem);
    }
    return result;
  }
}
