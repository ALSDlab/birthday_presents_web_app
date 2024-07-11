import 'package:Birthday_Presents_List/view/page/list_for_guest_page/list_for_guest_page.dart';
import 'package:Birthday_Presents_List/view/page/list_for_guest_page/list_for_guest_page_view_model.dart';
import 'package:Birthday_Presents_List/view/page/main_page/main_page.dart';
import 'package:Birthday_Presents_List/view/page/navigation_page/navigation_page_view_model.dart';
import 'package:Birthday_Presents_List/view/page/navigation_page/scaffold_with_nav_bar.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_page.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_view_model.dart';
import 'package:Birthday_Presents_List/view/page/search_page/search_page.dart';
import 'package:Birthday_Presents_List/view/page/search_page/search_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'di/get_it.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
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
            path: '/',
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
            redirect: (context, state) {
              // 직접 접근이 아닌 다른 페이지에서 이동 시에만 표시
              if (state.path == '/search_page' && state.extra == null) {
                return '/';
              }
              return null;
            },
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
          ),
          GoRoute(
            path: '/presents_list_page',
            redirect: (context, state) {
              // 직접 접근이 아닌 다른 페이지에서 이동 시에만 표시
              if (state.path == '/presents_list_page' && state.extra == null) {
                return '/';
              }
              return null;
            },
            builder: (context, state) {
              final extra = state.extra! as Map<String, dynamic>;
              final resetNavigation = extra['resetNavigation'];
              final hideNavBar = extra['hideNavBar'];
              final docId = extra['docId'];
              final name = extra['name'];
              final birthYear = extra['birthYear'];
              return ChangeNotifierProvider(
                create: (_) => getIt<PresentsListViewModel>(),
                child: PresentsListPage(
                  resetNavigation: resetNavigation,
                  hideNavBar: hideNavBar,
                  docId: docId,
                  name: name,
                  birthYear: birthYear,
                ),
              );
            },
          ),
        ]),
    GoRoute(
      path: '/:docId',
      // redirect: (context, state) {
      //   final String docId = state.pathParameters['docId']!;
      //   // 특정 페이지에 접근할 때 URL 전략 설정
      //   if (docId.length != 15) {
      //     return '/';
      //   }
      //   usePathUrlStrategy();
      //   return null;
      // },
      builder: (context, state) {
        final docId = state.pathParameters['docId']!;
        return ChangeNotifierProvider(
          create: (_) => getIt<ListForGuestPageViewModel>(),
          child: ListForGuestPage(docId: docId),
        );
      },
    ),
  ],
);
