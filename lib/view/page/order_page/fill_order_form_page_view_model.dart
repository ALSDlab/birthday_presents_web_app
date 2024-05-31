import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/coupons_model.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/domain/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/sales_model.dart';
import '../../../data/model/shopping_cart_model.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repository/product_repository_impl.dart';
import '../../../utils/simple_logger.dart';
import 'fill_order_form_page_state.dart';

class FillOrderFormPageViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  ProductRepositoryImpl repository = ProductRepositoryImpl();

  FillOrderFormPageViewModel({
    required this.userRepository,
  }) {
    getUserList();
  }

  final gridLeftArray = ['주문자명', '휴대폰번호', '주 소', '', '상세주소'];
  Map<String, TextEditingController> controllers = {};
  DataModel? daumPostcodeSearchDataModel;

  List<UserModel> currentUser = [];
  List myCouponList = [null];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController extraAddressController = TextEditingController();

  FillOrderFormPageState _state = const FillOrderFormPageState();

  FillOrderFormPageState get state => _state;

  String _address = '';
  String _zoneCode = '';

  String get address => _address;

  String get zoneCode => _zoneCode;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    nameController.dispose();
    phoneController.dispose();
    postcodeController.dispose();
    addressController.dispose();
    extraAddressController.dispose();
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<void> getUserList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final String userId = FirebaseAuth.instance.currentUser!.email!
          .replaceAll('@gmail.com', '');
      int dotIndex = userId.indexOf('.');
      String currentUserId = userId.substring(dotIndex + 1);

      // logger.info(userId?.email!.replaceAll('@gmail.com', ''));
      currentUser = await userRepository.getFirebaseUserData(currentUserId);
      fillTextField();
      for (int couponId in currentUser.first.coupons) {
        CouponsModel? myCoupon = await getMyCoupon(couponId);
        myCouponList.add(myCoupon!);
      }
      notifyListeners();
    } catch (error) {
      // 에러 처리
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void setAddress(String newZoneCode, String newAddress) {
    _address = newAddress;
    _zoneCode = newZoneCode;
    notifyListeners();
  }

  void fillTextField() {
    nameController.text = ((currentUser.isNotEmpty)
        ? currentUser.first.name
        : (nameController.text));
    controllers['name'] = (nameController);
    phoneController.text = (currentUser.isNotEmpty)
        ? currentUser.first.phone
        : (phoneController.text);
    controllers['phone'] = (phoneController);
    postcodeController.text =
        (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.postcode
            : (daumPostcodeSearchDataModel?.zonecode) ?? zoneCode;
    controllers['post'] = (postcodeController);
    addressController.text =
        (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.address
            : (daumPostcodeSearchDataModel?.address) ?? address;
    controllers['address'] = (addressController);
    extraAddressController.text = (currentUser.isNotEmpty)
        ? currentUser.first.addressDetail
        : (extraAddressController.text);
    controllers['extraAddress'] = (extraAddressController);
    notifyListeners();
  }

  void addressChangeRequest() {
    _state = state.copyWith(addressChange: true);
    notifyListeners();
  }

  Future<SalesModel?> getSalesContent(int saleId) async {
    SalesModel? salesContent = await repository.getSales(saleId);
    return salesContent;
  }

  Future<CouponsModel?> getMyCoupon(int couponId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    CouponsModel? myCoupon = await userRepository.getCoupon(couponId);
    _state = state.copyWith(isLoading: false);
    notifyListeners();
    return myCoupon;
  }

  Future<bool> saveOrdersInfo(
    CouponsModel? selectedCoupon,
    OrderModel item,
    int itemsCount,
    String currentDate,
    bool personalInfoForDeliverChecked,
    String ordererId,
    String ordererName,
    String ordererPhoneNo,
    String ordererAddress,
    String ordererAddressDetail,
    String ordererPostcode,
  ) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final salesContent = await getSalesContent(item.salesId);
      final itemPayAmount = item.count *
          int.parse((salesContent != null)
              ? deCalculatedPrice(item.price.replaceAll(',', ''), salesContent)
              : item.price.replaceAll(',', ''));
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(item.orderId + item.productId)
          .set(
        {
          'orderId': item.orderId,
          'productId': item.productId,
          'orderProductName': item.orderProductName,
          'representativeImage': item.representativeImage,
          'price': item.price,
          'count': item.count,
          'salesId': item.salesId,
          'orderedDate': item.orderedDate,
          'usedCouponPriceInOrder': (selectedCoupon == null)
              ? 0
              : (selectedCoupon.dcAmount > 0)
                  ? selectedCoupon.dcAmount / itemsCount
                  : itemPayAmount * selectedCoupon.dcRate / 100,
          'personalInfoForDeliverChecked': personalInfoForDeliverChecked,
          'ordererId': ordererId,
          'ordererName': ordererName,
          'ordererPhoneNo': ordererPhoneNo,
          'ordererAddress': ordererAddress,
          'ordererAddressDetail': ordererAddressDetail,
          'ordererPostcode': ordererPostcode,
          'payAndStatus': 0,
          'payAmount': itemPayAmount,
          'paymentDate': '',
          'deletedDate': '',
        },
      );
    } catch (error) {
      // 에러 처리
      logger.info('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
    return true;
  }

  String deCalculatedPrice(String originalPrice, SalesModel saleContent) {
    num resultPrice = int.parse(originalPrice);
    if (saleContent.salesRate <= 0 && saleContent.salesAmount > 0) {
      resultPrice = int.parse(originalPrice) - saleContent.salesAmount;
    } else if (saleContent.salesRate > 0 && saleContent.salesAmount <= 0) {
      resultPrice =
          (int.parse(originalPrice) * (100 - saleContent.salesRate) / 100).round();
    }
    return resultPrice.toString();
  }

  Future<int> updateShoppingCart(List<OrderModel> orderItems) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      List<ShoppingProductForCart> currentList = await getShoppingCartList();
      List<String> orderIds = orderItems.map((e) => e.orderId).toSet().toList();
      currentList.removeWhere((e) => orderIds.contains(e.orderId));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString =
          jsonEncode(currentList.map((e) => e.toJson()).toList());
      prefs.setString('shoppingCartList', jsonString);
      return currentList.length;
    } catch (error) {
      // 에러 처리
      logger.info('Error update shoppingcart: $error');
      return 0;
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

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
}
