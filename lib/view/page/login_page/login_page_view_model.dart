import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/domain/user_repository.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/order_model.dart';
import '../../../domain/order_repository.dart';
import '../../../utils/simple_logger.dart';
import 'login_page_state.dart';

SharedPreferences? prefs;

class LoginPageViewModel with ChangeNotifier {
  final UserRepository userRepository;
  final OrderRepository orderRepository;

  LoginPageViewModel({
    required this.orderRepository,
    required this.userRepository,

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
      // 아이디로 유저정보를 우선 확인
      int recreatedCount = 0;
      final currentUser = await userRepository.getFirebaseUserData(id);
      if (currentUser.isNotEmpty){
        recreatedCount = currentUser.first.recreatCount;
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '$recreatedCount.$id@gmail.com', password: password);
      if (context.mounted) {
        prefs!.setString('_email', '$recreatedCount.$id@gmail.com');
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return OneAnswerDialog(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: '안녕하세요, ${currentUser.first.name} 고객님',
                    subtitle: '로그인 되었습니다.',
                    firstButton: '확인',
                    imagePath: 'assets/gifs/success.gif');
              });
        }
        context.go('/main_page');
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              logger.info(e);
              return OneAnswerDialog(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: '알림',
                  subtitle: '정보가 없습니다.',
                  firstButton: '확인',
                  imagePath: 'assets/gifs/alert.gif');
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
        if (state.orderItems.first.ordererId != 'notRegistered') {
          showDialog(
              context: context,
              builder: (context) {
                return OneAnswerDialog(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: '알림',
                    subtitle: '로그인을 해주세요',
                    firstButton: '확인',
                    imagePath: 'assets/gifs/alert.gif');
              });
        } else {
          if (state.orderItems.first.ordererName != ordererName) {
            showDialog(
                context: context,
                builder: (context) {
                  return OneAnswerDialog(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: '알림',
                      subtitle: '주문자명이 맞지 않습니다.',
                      firstButton: '확인',
                      imagePath: 'assets/gifs/alert.gif');
                });
          } else if (state.orderItems.isEmpty) {
            showDialog(
                context: context,
                builder: (context) {
                  return OneAnswerDialog(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: '알림',
                      subtitle: '주문정보가 없습니다.',
                      firstButton: '확인',
                      imagePath: 'assets/gifs/alert.gif');
                });
          } else {
            result = state.orderItems;
          }
        }
      }
      notifyListeners();
      return result;
    } catch (error) {
      // 에러 처리
      logger.info('Error order check: $error');
      notifyListeners();

      return [];
    }
  }

  Future<void> getMyOrderData(String orderNumberForPay) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final myOrder =
          await orderRepository.getFirebaseOrdersByOrderNo(orderNumberForPay);
      logger.info(myOrder);
      _state = state.copyWith(orderItems: myOrder);

      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
