import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/order_model.dart';
import '../../../domain/order_repository.dart';
import '../../../utils/simple_logger.dart';
import 'login_page_state.dart';

SharedPreferences? prefs;

class LoginPageViewModel with ChangeNotifier {
  final OrderRepository orderRepository;

  LoginPageViewModel({
    required this.orderRepository,
  });

  LoginPageState _state = const LoginPageState();

  LoginPageState get state => _state;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future signIn(String id, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '$id@gmail.com', password: password);
      if (context.mounted) {
        prefs!.setString('_email', '$id@gmail.com');
        context.go('/main_page');
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              logger.info(e);
              return AlertDialog(
                title: const Text('알림'),
                content: const Text('정보가 없습니다.'),
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
  }

  Future<String> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String idMemory = prefs!.getString('_email') ?? '';
    return idMemory;
  }

  // 비회원 주문조회 메서드
  Future<List<OrderModel>> orderCheckforNoMember(
      String orderNumber, String ordererName, BuildContext context) async {
    try {
      await getMyOrderData(orderNumber);
      List<OrderModel> result = [];
      if (context.mounted) {
        if (state.orderItems.first.orderId != 'notRegistered') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('알림'),
                  content: const Text('로그인을 해주세요'),
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
        } else {
          if (state.orderItems.first.ordererName != ordererName) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('알림'),
                    content: const Text('주문자명이 맞지 않습니다.'),
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
          } else if (state.orderItems.isEmpty) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('알림'),
                    content: const Text('주문정보가 없습니다.'),
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
          } else {
            result = state.orderItems;
          }
        }
      }
      return result;
    } catch (error) {
      // 에러 처리
      logger.info('Error order check: $error');
      return [];
    }
  }

  Future<void> getMyOrderData(String orderNumberForPay) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final myOrder =
          await orderRepository.getFirebaseMyOrders(orderNumberForPay);
      // logger.info(myOrder);
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
