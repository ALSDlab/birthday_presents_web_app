import 'dart:convert';

import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/domain/order_repository.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page_state.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';

import '../../../data/model/coupons_model.dart';
import '../../../data/model/sales_model.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repository/product_repository_impl.dart';
import '../../../domain/user_repository.dart';
import '../../../env/env.dart';
import '../../../utils/send_sms_widget.dart';
import '../../../utils/simple_logger.dart';

class PayPageViewModel extends ChangeNotifier {
  ProductRepositoryImpl repository = ProductRepositoryImpl();
  final UserRepository userRepository;
  final OrderRepository orderRepository;

  PayPageViewModel({
    required this.userRepository,
    required this.orderRepository,
  });

  PayPageState _state = const PayPageState();

  PayPageState get state => _state;

  List<int> afterPayStatus = [];
  List<UserModel> currentUser = [];
  List myCouponList = [null];
  int dcResult = 0;
  DateTime todayDate = DateTime.now();

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

  Future<void> fetchMyOrderData(String orderNumberForPay) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final String userId = firebase_auth
          .FirebaseAuth.instance.currentUser!.email!
          .replaceAll('@gmail.com', '');
      int dotIndex = userId.indexOf('.');
      String currentUserId = userId.substring(dotIndex + 1);

      // logger.info(userId?.email!.replaceAll('@gmail.com', ''));
      currentUser = await userRepository.getFirebaseUserData(currentUserId);
      final myOrder =
          await orderRepository.getFirebaseOrdersByOrderNo(orderNumberForPay);
      // logger.info(myOrder);
      _state = state.copyWith(orderItems: myOrder);
      if (currentUser.isNotEmpty) {
        for (Map<String, dynamic> couponItem in currentUser.first.coupons) {
          CouponsModel? myCoupon = await getMyCoupon(couponItem);
          if(myCoupon != null && myCoupon.validDays - couponVaildCalculate(myCoupon) > 0 ) {
            myCouponList.add(myCoupon);
          }
        }
      }

      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<Map<String, SalesModel?>> getSalesContentsList(
      List<OrderModel> forOrderItems) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    Map<String, SalesModel?> salesContentsList = {};
    for (var product in forOrderItems) {
      SalesModel? salesContent = await repository.getSales(product.salesId);
      salesContentsList[product.productId] = salesContent;
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
    return salesContentsList;
  }

  Future<CouponsModel?> getMyCoupon(Map<String, dynamic> couponItem) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    CouponsModel? myCoupon = await userRepository.getCoupon(couponItem);
    _state = state.copyWith(isLoading: false);
    notifyListeners();
    return myCoupon;
  }

  // 쿠폰 유효기간 확인
  int couponVaildCalculate(CouponsModel myCouponItem){
    final DateTime startDate = DateTime.parse(currentUser.first.coupons.firstWhere((e) => e['couponId'] == myCouponItem.couponId)['startDate']);
    // 날짜 차이 계산 (단위: 일)
    Duration difference = todayDate.difference(startDate);
    return difference.inDays;
  }

  // 쿠폰 적용으로 할인된 금액 계산
  void calculateDcByCoupon(
      List<OrderModel> orderItems, CouponsModel? selectedCoupon) {
    if (selectedCoupon != null) {
      if (orderItems.isNotEmpty && selectedCoupon.dcAmount <= 0) {
        num result = orderItems.fold(
            0, (e, v) {
              return e + ((v.payAmount != null) ? v.payAmount! : 0) * selectedCoupon.dcRate / 100;
            });
        dcResult = result.round();
      } else {
        dcResult = selectedCoupon.dcAmount;
      }
    }
  }

  Future<void> postPaidItems(
      BuildContext context, List<OrderModel> orderItems, int payStatus, int? usedCouponId, int actualPaymentByOrder) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      for (OrderModel item in orderItems) {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(item.orderId + item.productId)
            .update({
          'payAndStatus': payStatus,
          'usedCouponId': usedCouponId,
          'actualPaymentByOrder': actualPaymentByOrder,
          'paymentDate': DateTime.now().toString().substring(0, 21)
        });
      }
      // 사용된 쿠폰 삭제기능
      if (orderItems.first.ordererId != null) {
        await userRepository.deleteUsedCoupon(orderItems.first.ordererId!, usedCouponId);
      }

      notifyListeners();
    } catch (error) {
      // 에러 처리
      logger.info('Error post payInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void showSnackbar(BuildContext context) {
    _state = state.copyWith(showSnackbarPadding: true);
    notifyListeners();

    final snackBar = SnackBar(
      content: const Text('주문번호가 생성되었습니다.'),
      duration: const Duration(seconds: 2),
      onVisible: () {
        // snackbar가 사라질 때 패딩을 제거합니다.
        Future.delayed(const Duration(milliseconds: 2200), () {
          _state = state.copyWith(showSnackbarPadding: false);
          notifyListeners();
        });
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> checkPayItems(List<OrderModel> orderItems) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await Future.forEach(orderItems.asMap().entries, (entry) async {
        final item = entry.value;
        var query = FirebaseFirestore.instance
            .collection('orders')
            .where('orderId', isEqualTo: item.orderId);
        await query.get().then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            for (var document in querySnapshot.docs) {
              afterPayStatus.add(
                  OrderModel.fromJson(document.data() as Map<String, dynamic>)
                      .payAndStatus!);
            }
          }
        });
      });
    } catch (error) {
      // 에러 처리
      logger.info('Error post payInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void bootpayPayment(BuildContext context, List<OrderModel> orderItems,
      num totalPayment, int? usedCouponId, bool Function(bool) hideNavBar) {
    Payload payload = getPayload(totalPayment);
    if (kIsWeb) {
      payload.extra!.openType = "iframe";
    }

    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        logger.info('------- onCancel: $data');
      },
      onError: (String data) async {
        logger.info('------- onError: $data');
        await postPaidItems(context, orderItems, -1, usedCouponId, 0);
      },
      onClose: () async {
        logger.info('------- onClose');
        await checkPayItems(orderItems);
        if (context.mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          showDialog(
            context: context,
            builder: (context) {
              return OneAnswerDialog(
                  onTap: () {
                    Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
                    context.pop();
                  },
                  imagePath: afterPayStatus.every((e) => e == 1)
                      ? 'assets/gifs/success.gif'
                      : 'assets/gifs/fail.gif',
                  title: afterPayStatus.every((e) => e == 1)
                      ? '결제가 완료되었습니다.'
                      : '결제가 실패하였습니다.',
                  subtitle: afterPayStatus.every((e) => e == 1)
                      ? '주문해 주셔서 감사합니다.'
                      : '다시 시도해 주세요',
                  firstButton: '확인');
            },
          );
          logger.info(
              '[민영기염소탕]주문완료.\n주문번호: ${_state.orderItems.first.orderId}\n${_state.orderItems.first.ordererName} 고객님, 저희 제품을\n구매해 주셔서 감사드립니다.');
          sendSMS('01058377427', _state.orderItems.first.ordererPhoneNo!,
              '[민영기염소탕]주문완료.\n주문번호: ${_state.orderItems.first.orderId}\n${_state.orderItems.first.ordererName} 고객님, 저희 제품을\n구매해 주셔서 감사드립니다.');
          hideNavBar(false);
        }
      },
      onIssued: (String data) {
        logger.info('------- onIssued: $data');
      },
      onConfirm: (String data) {
        logger.info('------- onConfirm: $data');
        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 비동기 승인 하고자 할 때
            checkQtyFromServer(data);
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        // checkQtyFromServer(data);
        return true;
      },
      onDone: (String data) async {
        logger.info('------- onDone: $data');
        String paidResultData = jsonDecode(data)['event'];
        logger.info(paidResultData);
        if (paidResultData == 'done') {
          await postPaidItems(
              context, orderItems, 1, usedCouponId, totalPayment.toInt()); // 결제완료되면 서버로 pay status 변경
        }
      },
    );
  }

  Payload getPayload(num totalAmount) {
    Payload payload = Payload();
    Item item1 = Item();
    item1.name = (_state.orderItems.length > 1)
        ? '${_state.orderItems.first.orderProductName} 외 ${_state.orderItems.length - 1}건 (주문번호: ${_state.orderItems.first.orderId})'
        : '${_state.orderItems.first.orderProductName} (주문번호: ${_state.orderItems.first.orderId})'; // 주문정보에 담길 상품명
    item1.qty = 1; // 해당 상품의 주문 수량
    item1.id = "ITEM_CODE_MYK_GOAT"; // 해당 상품의 고유 키
    item1.price = totalAmount.toDouble(); // 상품의 가격

    List<Item> itemList = [item1];

    payload.androidApplicationId =
        Env.androidApplicationId; // android application id
    payload.iosApplicationId = Env.iosApplicationId; // ios application id
    payload.webApplicationId = Env.webApplicationId; // web application id

    payload.pg = '나이스페이';
    // payload.method = '카드';
    // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
    payload.orderName = item1.name; //결제할 상품명
    payload.price = item1.price; //정기결제시 0 혹은 주석

    payload.orderId = _state.orderItems.first
        .orderId; //주문번호, 개발사에서 고유값으로 지정해야함 ('userId + epoch time' 형태로 지정)

    payload.metadata = {
      "구매자 ID": _state.orderItems.first.ordererId,
      "구매자 이름": _state.orderItems.first.ordererName,
      // "구매자 E-mail": _state.orderItems.first.ordererId,
      "구매상품": "${_state.orderItems.length} 개",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값, 부트페이 관리자 화면에서 확인

    User user = User(); // 구매자 정보
    user.id = _state.orderItems.first.ordererId;
    user.username = _state.orderItems.first.ordererName;
    user.phone = _state.orderItems.first.ordererPhoneNo;
    user.addr =
        '${_state.orderItems.first.ordererAddress} ${_state.orderItems.first.ordererAddressDetail}, 우)${_state.orderItems.first.ordererPostcode}';
    // user.email = _state.userAccountModel!.email;

    Extra extra = Extra(); // 결제 옵션
    extra.cardQuota = '1,2,3'; // 5만원 이상 결제 시 할부 가능 범위 옵션
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.items = itemList;
    payload.extra = extra;
    return payload;
  }
}
