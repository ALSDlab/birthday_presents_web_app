import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/order_model.dart';
import '../../../utils/simple_logger.dart';

SharedPreferences? prefs;

class LoginViewModel with ChangeNotifier {
  Future signIn(String id, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: '$id@gmail.com', password: password);
      if (context.mounted) {
        prefs!.setString('_email', '$id@gmail.com');
        context.go('/main_page');
      }
    } catch (e) {
      showDialog(context: context, builder: (context) {
        print(e);
        return AlertDialog(
          title: Text('알림'),
          content: Text('정보가 없습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'),
            )
          ],
        );
      });
    }
  }

  Future<String> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String idMemory = prefs!.getString('_email') ?? '';
    return idMemory;
  }


  // 비회원 주문조회 메서드
 Future<List<OrderModel>> orderCheckforNoMember(String orderNumber, String ordererName) async {
   try {
     await fetchMyOrderData(orderNumber);
   } catch (error) {
     // 에러 처리
     logger.info('Error init data: $error');
   }


 }


  Future<void> fetchMyOrderData(String orderNumberForPay) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final myOrder =
      await orderRepository.getFirebaseMyOrders(orderNumberForPay);
      logger.info(myOrder);
      _state = state.copyWith(orderItems: myOrder);

      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }



}