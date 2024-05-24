import 'package:get_it/get_it.dart';
import 'package:myk_market_app/view/page/find_id_password_page/find_id_password_page_view_model.dart';

import '../data/repository/order_repository_impl.dart';
import '../data/repository/user_repository_impl.dart';
import '../domain/order_repository.dart';
import '../domain/user_repository.dart';
import '../view/page/login_page/login_page_view_model.dart';
import '../view/page/order_history_page/order_history_page_view_model.dart';
import '../view/page/order_page/fill_order_form_page_view_model.dart';
import '../view/page/pay_page/pay_page_view_model.dart';
import '../view/page/shopping_cart_page/shopping_cart_view_model.dart';
import '../view/page/signup_page/signup_page_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Repository
  getIt
    ..registerSingleton<OrderRepository>(
      OrderRepositoryImpl(),
    )
    ..registerSingleton<UserRepository>(
      UserRepositoryImpl(),
    );

  // ViewModel
  getIt
    ..registerFactory<PayPageViewModel>(
        () => PayPageViewModel(orderRepository: getIt<OrderRepository>()))
    ..registerFactory<FillOrderFormPageViewModel>(() =>
        FillOrderFormPageViewModel(userRepository: getIt<UserRepository>()))
    ..registerFactory<FindIdPasswordViewModel>(() =>
        FindIdPasswordViewModel(userRepository: getIt<UserRepository>()))
    ..registerFactory<ShoppingCartViewModel>(() => ShoppingCartViewModel())
    ..registerFactory<LoginPageViewModel>(
        () => LoginPageViewModel(orderRepository: getIt<OrderRepository>()))
    ..registerFactory<OrderHistoryPageViewModel>(() =>
        OrderHistoryPageViewModel(orderRepository: getIt<OrderRepository>()))
    ..registerFactory<SignupPageViewModel>(() =>
        SignupPageViewModel());
}
