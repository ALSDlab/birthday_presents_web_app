import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/domain/order_repository.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page_state.dart';

class PayPageViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;

  PayPageViewModel({
    required this.orderRepository,
  });

  PayPageState _state = const PayPageState();

  PayPageState get state => _state;

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
      debugPrint('Error init data: $error');
    }
  }

  Future<void> fetchMyOrderData(String orderNumberForPay) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final myOrder =
          await orderRepository.getFirebaseMyOrders(orderNumberForPay);
      print(myOrder);
      _state = state.copyWith(orderItems: myOrder);

      notifyListeners();
    } catch (error) {
      // 에러 처리
      debugPrint('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
