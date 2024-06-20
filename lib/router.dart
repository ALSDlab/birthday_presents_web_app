import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/main_page/main_page.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:myk_market_app/view/page/navigation_page/scaffold_with_nav_bar.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page_view_model.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page.dart';
import 'package:myk_market_app/view/page/product_detail_page/product_detail_page_view_model.dart';
import 'package:myk_market_app/view/page/product_page/product_page.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_page.dart';
import 'package:myk_market_app/view/page/shopping_cart_page/shopping_cart_view_model.dart';
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
                child: ChangeNotifierProvider(
              create: (_) => ProductDetailPageViewModel(),
              child: ScaffoldWithNavBar(
                location: state.matchedLocation,
                child: child,
              ),
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
            builder: (context, state) {
              final extra = state.extra! as Map<String, dynamic>;
              final navSetState = extra['navSetState'];
              final hideNavBar = extra['hideNavBar'];
              return ChangeNotifierProvider(
                create: (_) => ProductViewModel(),
                child: ProductPage(
                    navSetState: navSetState, hideNavBar: hideNavBar),
              );
            },
          ),
          GoRoute(
              path: '/shopping_cart_page',
              builder: (context, state) {
                final extra = state.extra! as Map<String, dynamic>;
                final navSetState = extra['navSetState'];
                final hideNavBar = extra['hideNavBar'];
                return ChangeNotifierProvider(
                  create: (_) => getIt<ShoppingCartViewModel>(),
                  child: ShoppingCartPage(
                      navSetState: navSetState, hideNavBar: hideNavBar),
                );
              },
              routes: [
                GoRoute(
                    path: 'fill_order_page',
                    builder: (context, state) {
                      final extra = state.extra! as Map<String, dynamic>;
                      final hideNavBar = extra['hideNavBar'];
                      final navSetState = extra['navSetState'];
                      return ChangeNotifierProvider(
                        create: (_) => getIt<FillOrderFormPageViewModel>(),
                        child: FillOrderFormPage(
                            forOrderItems: extra['orderModelList'],
                            hideNavBar: hideNavBar,
                            navSetState: navSetState),
                      );
                    },
                    ),
              ]),

          GoRoute(
            path: '/product_detail_page',
            builder: (context, state) {
              final extra = state.extra! as Map<String, dynamic>;
              final productDetailMap = extra['product'];
              final navSetState = extra['navSetState'];
              final hideNavBar = extra['hideNavBar'];
              final salesContent = extra['salesContent'];
              return ChangeNotifierProvider(
                  create: (_) => ProductDetailPageViewModel(),
                  child: ProductDetailPage(
                      product: productDetailMap,
                      navSetState: navSetState,
                      hideNavBar: hideNavBar,
                      salesContent: salesContent,));
            },
          ),
        ]),
  ],
);
