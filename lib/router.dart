import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/view/page/login_page/login_page.dart';
import 'package:myk_market_app/view/page/agreement_page/agreement_page.dart';
import 'package:myk_market_app/view/page/main_page/main_page.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page_view_model.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:myk_market_app/view/page/product_page/product_page.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_page.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/main_page',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => PersistentTabView.router(
        tabs: [
          PersistentRouterTabConfig(
            item: ItemConfig(
                icon: const Icon(Icons.home),
                title: "홈",
                textStyle: const TextStyle(fontFamily: 'Jalnan', fontSize: 11)),
          ),
          PersistentRouterTabConfig(
            item: ItemConfig(
                icon: const Icon(Icons.format_align_justify),
                title: "상품",
                textStyle: const TextStyle(fontFamily: 'Jalnan', fontSize: 11)),
          ),
          PersistentRouterTabConfig(
            item: ItemConfig(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                title: "장바구니",
                textStyle: const TextStyle(fontFamily: 'Jalnan', fontSize: 11)),
          ),
          PersistentRouterTabConfig(
            item: ItemConfig(
                icon: const Icon(
                  Icons.person,
                ),
                title: "마이페이지",
                textStyle: const TextStyle(fontFamily: 'Jalnan', fontSize: 11)),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style4BottomNavBar(
          navBarConfig: navBarConfig,
        ),
        navigationShell: navigationShell,
      ),
      branches: [
        // 회사소개 페이지
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: "/main_page",
              builder: (context, state) => ChangeNotifierProvider(
                create: (_) => StoreViewModel(),
                child: const MainPage(),
              ),
            ),
          ],
        ),
        // 상품목록 페이지
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: "/product_page",
              builder: (context, state) => ChangeNotifierProvider(
                create: (_) => ProductViewModel(),
                child: const ProductPage(),
              ),
            ),
          ],
        ),
        // 장바구니 페이지
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                path: "/shopping_cart_page",
                builder: (context, state) => ChangeNotifierProvider(
                      create: (_) => ShoppingCartViewModel(),
                      child: ShoppingCartPage(),
                    ),
                routes: [
                  GoRoute(
                    path: "pay_page",
                    builder: (context, state) => PayPage(
                      forOrderItems: [],
                    ),
                  )
                ]),
          ],
        ),
        // 마이페이지
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: "/login_page",
                builder: (context, state) => const LoginPage(),
                routes: [
                  GoRoute(
                      path: "my_detail_page",
                      builder: (context, state) => const AgreementPage(),
                      routes: [
                        GoRoute(
                          path: "signup_page",
                          builder: (context, state) => SignupPage(
                            isPersonalInfoForDeliverChecked:
                                state.extra! as bool,
                          ),
                        ),
                      ]),
                ])
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/product_detail_page",
      builder: (context, state) {
        final productDetailMap = state.extra! as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => ProductDetailPageViewModel(),
          child: ProductDetailPage(
            product: productDetailMap['product'],
          ),
        );
      },
    ),
    GoRoute(
      path: "/fill_order_page",
      builder: (context, state) {
        final fillOrderFormList = state.extra! as List<OrderModel>;
        return ChangeNotifierProvider(
          create: (_) => FillOrderFormPageViewModel(),
          child: FillOrderFormPage(
            forOrderItems: fillOrderFormList,
          ),
        );
      },
    ),
  ],
);
