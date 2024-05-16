import 'dart:convert';

import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/domain/order_repository.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page_state.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';

import '../../../env/env.dart';
import '../../../utils/simple_logger.dart';

class PayPageViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;

  PayPageViewModel({
    required this.orderRepository,
  });

  PayPageState _state = const PayPageState();

  PayPageState get state => _state;

  List<int> afterPayStatus = [];

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

  void init(String orderNumberForPay) async {
    try {
      await fetchMyOrderData(orderNumberForPay);
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
          await orderRepository.getFirebaseOrdersByOrderNo(orderNumberForPay);
      logger.info(myOrder);
      _state = state.copyWith(orderItems: myOrder);

      notifyListeners();
    } catch (error) {
      // 에러 처리
      debugPrint('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void postPaidItems(List<OrderModel> orderItems, int payStatus) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      await Future.forEach(orderItems.asMap().entries, (entry) async {
        final index = entry.key;
        final item = entry.value;
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(item.orderId + item.productId)
            .update({
          'payAndStatus': payStatus,
          'paymentDate': DateTime.now().toString().substring(0, 21)
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

  void bootpayPayment(BuildContext context, List<OrderModel> orderItems) {
    int totalAmount = 0;
    for (var e in orderItems) {
      totalAmount += e.payAmount!;
    }
    // totalAmount = 100; // 테스트용
    Payload payload = getPayload(totalAmount);
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
      onError: (String data) {
        logger.info('------- onError: $data');
        postPaidItems(orderItems, -1);
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

              //   AlertDialog(
              //   content: Text(afterPayStatus.every((e) => e == 1)
              //       ? '결제가 완료되었습니다.'
              //       : '결제가 실패하였습니다. 다시 시도해 주세요'),
              //   actions: [
              //     TextButton(
              //       onPressed: () {
              //         Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
              //         context.pop();
              //       },
              //       child: const Text('확인'),
              //     ),
              //   ],
              // );
            },
          );
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
      onDone: (String data) {
        logger.info('------- onDone: $data');
        String paidResultData = jsonDecode(data)['event'];
        logger.info(paidResultData);
        if (paidResultData == 'done') {
          postPaidItems(orderItems, 1); // 결제완료되면 서버로 pay status 변경
        }
      },
    );
  }

  Payload getPayload(int totalAmount) {
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
    extra.cardQuota = '3'; // 5만원 이상 결제 시 할부 가능 범위 옵션
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.items = itemList;
    payload.extra = extra;
    return payload;
  }
}
