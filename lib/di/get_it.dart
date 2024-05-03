import 'package:get_it/get_it.dart';

import '../data/repository/order_repository_impl.dart';
import '../data/repository/user_repository_impl.dart';
import '../domain/order_repository.dart';
import '../domain/user_repository.dart';
import '../view/page/order_page/fill_order_form_page_view_model.dart';
import '../view/page/pay_page/pay_page_view_model.dart';

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
        FillOrderFormPageViewModel(userRepository: getIt<UserRepository>()));
}
