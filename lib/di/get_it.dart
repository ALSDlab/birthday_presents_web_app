import 'package:get_it/get_it.dart';

import '../data/repository/order_repository_impl.dart';
import '../domain/order_repository.dart';
import '../view/page/pay_page/pay_page_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Repository
  getIt.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(),
  );

  // ViewModel
  getIt.registerFactory<PayPageViewModel>(
      () => PayPageViewModel(orderRepository: getIt<OrderRepository>()));
}
