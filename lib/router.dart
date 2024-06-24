import 'package:Birthday_Presents_List/view/page/main_page/main_page.dart';
import 'package:Birthday_Presents_List/view/page/navigation_page/navigation_page_view_model.dart';
import 'package:Birthday_Presents_List/view/page/navigation_page/scaffold_with_nav_bar.dart';
import 'package:Birthday_Presents_List/view/page/search_page/amazon_webview_page.dart';
import 'package:Birthday_Presents_List/view/page/search_page/search_page.dart';
import 'package:Birthday_Presents_List/view/page/search_page/search_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => getIt<SearchPageViewModel>(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => getIt<NavigationPageViewModel>(),
                  ),
                ],
                child: ScaffoldWithNavBar(
                  location: state.matchedLocation,
                  child: child,
                ),
              ),
            ),
        routes: [
          GoRoute(
            path: '/main_page',
            builder: (context, state) {
              final navigationViewModel =
                  Provider.of<NavigationPageViewModel>(context, listen: false);
              return ChangeNotifierProvider(
                create: (_) => getIt<NavigationPageViewModel>(),
                child: MainPage(
                  hideNavBar: navigationViewModel.hideNavBar,
                  resetNavigation: navigationViewModel.resetNavigation,
                ),
              );
            },
          ),
          GoRoute(
              path: '/search_page',
              builder: (context, state) {
                final extra = state.extra! as Map<String, dynamic>;
                final resetNavigation = extra['resetNavigation'];
                final hideNavBar = extra['hideNavBar'];
                final docId = extra['docId'];
                final name = extra['name'];
                final birthYear = extra['birthYear'];
                return ChangeNotifierProvider(
                    create: (_) => getIt<SearchPageViewModel>(),
                    child: SearchPage(
                      resetNavigation: resetNavigation,
                      hideNavBar: hideNavBar,
                      docId: docId,
                      name: name,
                      birthYear: birthYear,
                    ));
              },
              // routes: [
              //   GoRoute(
              //       path: 'amazon_page',
              //       builder: (context, state) {
              //         final extra = state.extra! as Map<String, dynamic>;
              //         final name = extra['name'];
              //         final yearCountWithEnding = extra['yearCountWithEnding'];
              //         return AmazonWebviewPage(
              //             name: name, yearCountWithEnding: yearCountWithEnding);
              //       })
              // ]
              ),
          // GoRoute(
          //   path: '/presents_list_page',
          //   builder: (context, state) {
          //     final extra = state.extra! as Map<String, dynamic>;
          //     final resetNavigation = extra['resetNavigation'];
          //     final hideNavBar = extra['hideNavBar'];
          //     final docId = extra['docId'];
          //     final name = extra['name'];
          //     final birthYear = extra['birthYear'];
          //     return ChangeNotifierProvider(
          //       create: (_) => getIt<PresentsListViewModel>(),
          //       child: PresentsListPage(
          //         resetNavigation: resetNavigation,
          //         hideNavBar: hideNavBar,
          //         docId: docId,
          //         name: name,
          //         birthYear: birthYear,
          //       ),
          //     );
          //   },
          // ),
        ]),
  ],
);
