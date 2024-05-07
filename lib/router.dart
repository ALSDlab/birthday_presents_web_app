import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/view/page/agreement_page/agreement_page.dart';
import 'package:myk_market_app/view/page/login_page/login_page.dart';
import 'package:myk_market_app/view/page/main_page/main_page.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:myk_market_app/view/page/navigation_page/scaffold_with_nav_bar.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page_view_model.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page_view_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:myk_market_app/view/page/product_page/product_page.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:myk_market_app/view/page/profile_page/profile_page.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_page.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page.dart';
import 'package:provider/provider.dart';

import 'di/get_it.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/main_page',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) => NoTransitionPage(
                child: ScaffoldWithNavBar(
              location: state.matchedLocation,
              child: child,
            )),
        routes: [
          GoRoute(
            path: '/main_page',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => StoreViewModel(),
              child: const MainPage(),
            ),
          ),
          GoRoute(
            path: '/product_page',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => ProductViewModel(),
              child: const ProductPage(),
            ),
          ),
          GoRoute(
              path: '/shopping_cart_page',
              builder: (context, state) => ChangeNotifierProvider(
                    create: (_) => getIt<ShoppingCartViewModel>(),
                    child: const ShoppingCartPage(),
                  ),
              routes: [
                GoRoute(
                    path: 'fill_order_page',
                    builder: (context, state) {
                      return ChangeNotifierProvider(
                        create: (_) => getIt<FillOrderFormPageViewModel>(),
                        child: FillOrderFormPage(
                          forOrderItems: state.extra! as List<OrderModel>,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'pay_page',
                        builder: (context, state) {
                          return ChangeNotifierProvider(
                            create: (_) => getIt<PayPageViewModel>(),
                            child: PayPage(
                                forOrderItems:
                                    state.extra! as List<OrderModel>),
                          );
                        },
                      )
                    ]),
              ]),
          GoRoute(
              path: '/profile_page',
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                    path: 'login_page',
                    builder: (context, state) => const LoginPage(),
                    routes: [
                      GoRoute(
                          path: 'my_detail_page',
                          builder: (context, state) => const AgreementPage(),
                          routes: [
                            GoRoute(
                              path: 'signup_page',
                              builder: (context, state) => SignupPage(
                                isPersonalInfoForDeliverChecked:
                                    state.extra! as bool,
                              ),
                            ),
                          ]),
                    ]),
              ]),
          GoRoute(
            path: '/product_detail_page',
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
        ]),
  ],
);
