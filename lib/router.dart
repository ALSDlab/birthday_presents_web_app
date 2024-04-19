import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/main_page/navigation.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(initialLocation: '/main_page', routes: [
  // 회사소개 메인페이지
  GoRoute(
    path: '/main_page',
    builder: (context, state) => Navigation(
      selectedIndex: 0,
    ),
  ),
  GoRoute(
      path: '/product_page',
      builder: (context, state) => Navigation(
        selectedIndex: 1,
      ),),
  GoRoute(
    path: '/register_page',
    builder: (context, state) => Navigation(
      selectedIndex: 3,
    ),),
]);