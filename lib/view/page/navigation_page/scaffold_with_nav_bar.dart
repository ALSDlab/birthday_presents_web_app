import 'dart:async';
import 'dart:core';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../data/repository/connectivity_observer.dart';
import '../../../data/repository/network_connectivity_observer.dart';
import '../../../utils/simple_logger.dart';
import '../../widgets/one_answer_dialog.dart';
import '../search_page/search_page_view_model.dart';
import 'navigation_page_view_model.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  String location;

  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int badgeCount = 0;

  //네트워크 통신 확인 코드
  final ConnectivityObserver _connectivityObserver =
      NetworkConnectivityObserver();

  //기본 접속 상태 설정
  var _status = Status.available;

  StreamSubscription<Status>? _subscription;

  @override
  void initState() {
    Future.microtask(() async {
      final SearchPageViewModel viewModel = context.read<SearchPageViewModel>();
      badgeCount = await viewModel.getBadgeCount();

      _subscription = _connectivityObserver.observe().listen((status) {
        setState(() {
          _status = status;
          logger.info('Status changed : $_status');
          //인터넷 연결 확인 체크 코드
          if (_status == Status.unavailable) {
            showConnectionErrorDialog();
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        });
      });
    });
    super.initState();
  }

  //인터넷 연결 확인 체크 위젯
  void showConnectionErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OneAnswerDialog(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'Check WIFI',
            // subtitle: '신호없음',
            firstButton: 'OK',
            imagePath: 'assets/gifs/internetLost.gif');
      },
    );
  }


  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NavigationPageViewModel>();
    final searchPageViewModel = context.watch<SearchPageViewModel>();
    final state = searchPageViewModel.state;
    return Scaffold(
      body: Stack(
        children: [
          // BackImage(),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFF9C4).withOpacity(0.9),
                  const Color(0xFFFFF9C4).withOpacity(0.9),
                ],
              ),
            ),
          ),
          widget.child,
        ],
      ),
      bottomNavigationBar: (viewModel.isHideNavBar)
          ? null
          : StylishBottomBar(
              option: AnimatedBarOptions(
                padding: const EdgeInsets.only(top: 12),
                iconSize: 30,
                barAnimation: BarAnimation.fade,
                iconStyle: IconStyle.Default,
              ),
              items: [
                BottomBarItem(
                  icon: const Icon(BootstrapIcons.search_heart),
                  selectedIcon:
                      const Icon(BootstrapIcons.search_heart_fill, shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ]),
                  selectedColor: const Color(0xFF98FF98),
                  unSelectedColor: const Color(0xFF3A405A),
                  title: const Text(
                    'SEARCH',
                    style: TextStyle(fontFamily: 'KoPub', shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.grey,
                      ),
                    ]),
                  ),
                ),
                BottomBarItem(
                  icon: const Icon(BootstrapIcons.list_task),
                  selectedIcon: const Icon(BootstrapIcons.list_check, shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ]),
                  selectedColor: const Color(0xFF98FF98),
                  unSelectedColor: const Color(0xFF3A405A),
                  badge: Text('${viewModel.badgeCount}'),
                  showBadge: viewModel.badgeCount > 0,
                  badgeColor: Colors.red,
                  badgePadding: const EdgeInsets.only(left: 4, right: 4),
                  title: const Text(
                    'LIST',
                    style: TextStyle(fontFamily: 'KoPub', shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.grey,
                      ),
                    ]),
                  ),
                ),
              ],
              backgroundColor: const Color(0xFFAEC6CF),
              currentIndex: widget.location.contains('/search_page') ? 0 : 1,
              onTap: (int index) {
                if (_status == Status.unavailable) {
                  showConnectionErrorDialog();
                } else {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  GoRouter router = GoRouter.of(context);
                  List<String> locations = [
                    '/search_page',
                    '/presents_list_page',
                  ];
                  String? location = locations[index];
                  router.go(location, extra: {
                    'resetNavigation': viewModel.resetNavigation,
                    'hideNavBar': viewModel.hideNavBar(false),
                    'docId': NavigationPageViewModel.docId,
                    'name': NavigationPageViewModel.name,
                    'birthYear': NavigationPageViewModel.birthYear
                  });
                }
              },
            ),
    );
  }
}
