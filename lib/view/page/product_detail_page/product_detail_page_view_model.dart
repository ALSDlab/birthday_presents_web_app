import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_state.dart';

class ProductDetailPageViewModel extends ChangeNotifier {
  ProductDetailPageState _state = const ProductDetailPageState();

  ProductDetailPageState get state => _state;
  // int count = 1;

  void plusCount() {
    if (state.count <= 10) {
      // count++;
      _state = state.copyWith(count: state.count +1);
      notifyListeners();
    }
    print(state.count);
  }

  void minusCount() {
    if (state.count >= 2) {
      state.count-1;
      notifyListeners();
    }

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
}
