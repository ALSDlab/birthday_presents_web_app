import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/domain/user_repository.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_view_model.dart';

import '../../../data/model/user_model.dart';
import 'fill_order_form_page_state.dart';

class FillOrderFormPageViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  FillOrderFormPageViewModel({
    required this.userRepository,
  }) {
    getUserList();
  }

  final gridLeftArray = ['주문자명', '휴대폰번호', '주 소', '', '상세주소'];
  List<TextEditingController> controllers = [];
  DataModel? daumPostcodeSearchDataModel;


  List<UserModel> currentUser = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController extraAddressController = TextEditingController();

  FillOrderFormPageState _state = const FillOrderFormPageState();

  FillOrderFormPageState get state => _state;

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
      final userId = FirebaseAuth.instance.currentUser;

      // logger.info(userId?.email!.replaceAll('@gmail.com', ''));
      if (userId != null) {
        currentUser = await userRepository
            .getFirebaseUserData(userId.email!.replaceAll('@gmail.com', ''));
      }
      fillTextField();

      notifyListeners();
    } catch (error) {
      // 에러 처리
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();

    }
  }

  void fillTextField() {
    SignupViewModel viewModel = SignupViewModel();
    nameController.text =
        (currentUser.isNotEmpty) ? currentUser.first.name : '';
    controllers.add(nameController);
    phoneController.text =
        (currentUser.isNotEmpty) ? currentUser.first.phone : '';
    controllers.add(phoneController);
    postcodeController.text =
        (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.postcode
            : (daumPostcodeSearchDataModel?.zonecode) ?? viewModel.zoneCode;
    controllers.add(postcodeController);
    addressController.text =
    (currentUser.isNotEmpty && state.addressChange == false)
            ? currentUser.first.address
            : (daumPostcodeSearchDataModel?.address) ?? viewModel.address;
    controllers.add(addressController);
    extraAddressController.text =
        (currentUser.isNotEmpty) ? currentUser.first.addressDetail : '';
    controllers.add(extraAddressController);
    notifyListeners();

  }

  void addressChangeRequest() {
    _state = state.copyWith(addressChange: true);
    notifyListeners();

  }

  Future<bool> saveOrdersInfo(
    OrderModel item,
    String index,
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
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(item.orderId + index)
          .set(
        {
          'orderId': item.orderId,
          'orderProductName': item.orderProductName,
          'representativeImage': item.representativeImage,
          'price': item.price,
          'count': item.count,
          'orderedDate': item.orderedDate,
          'personalInfoForDeliverChecked': personalInfoForDeliverChecked,
          'ordererId': ordererId,
          'ordererName': ordererName,
          'ordererPhoneNo': ordererPhoneNo,
          'ordererAddress': ordererAddress,
          'ordererAddressDetail': ordererAddressDetail,
          'ordererPostcode': ordererPostcode,
          'payAndStatus': 0,
          'payAmount': int.parse(item.price.replaceAll(',', '')) * item.count,
          'paymentDate': ''
        },
      );
    } catch (error) {
      // 에러 처리
      debugPrint('Error saving ordersInfo: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();

    }
    return true;
  }
}
