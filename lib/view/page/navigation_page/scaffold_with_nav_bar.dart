import 'dart:async';
import 'dart:core';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../data/repository/connectivity_observer.dart';
import '../../../data/repository/network_connectivity_observer.dart';
import '../../widgets/one_answer_dialog.dart';
import '../product_detail_page/product_detail_page_view_model.dart';

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
  var _status = Status.unavailable;

  StreamSubscription<Status>? _subscription;

  bool resetNavigation(int newCount) {
    setState(() {
      badgeCount = newCount;
    });
    return true;
  }

  @override
  void initState() {
    Future.microtask(() async {
      final ProductDetailPageViewModel viewModel =
          context.read<ProductDetailPageViewModel>();
      badgeCount = await viewModel.getBadgeCount();

      _subscription = _connectivityObserver.observe().listen((status) {
        setState(() {
          _status = status;
          //print('Status changed : $_status');
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
            title: '신호없음',
            subtitle: '인터넷 연결을 확인해주세요',
            firstButton: '확인',
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFF2F362F),
                  BlendMode.dstATop,
                ),
                image: AssetImage(
                  'assets/images/background.png',
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          widget.child,
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          padding: const EdgeInsets.only(top: 12),
          iconSize: 30,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.Default,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(BootstrapIcons.house_door),
            selectedIcon: const Icon(BootstrapIcons.house_door_fill),
            selectedColor: const Color(0xFF2F362F),
            unSelectedColor: CupertinoColors.black,
            title: const Text(
              '홈',
              style: TextStyle(fontFamily: 'KoPub'),
            ),
          ),
          BottomBarItem(
            icon: const Icon(BootstrapIcons.box2),
            selectedIcon: const Icon(BootstrapIcons.box2_fill),
            selectedColor: const Color(0xFF2F362F),
            unSelectedColor: CupertinoColors.black,
            title: const Text(
              '상품',
              style: TextStyle(fontFamily: 'KoPub'),
            ),
          ),
          BottomBarItem(
            icon: const Icon(BootstrapIcons.cart_check),
            selectedIcon: const Icon(BootstrapIcons.cart_check_fill),
            selectedColor: const Color(0xFF2F362F),
            unSelectedColor: CupertinoColors.black,
            title: const Text('장바구니', style: TextStyle(fontFamily: 'KoPub')),
            badge: Text('$badgeCount'),
            showBadge: badgeCount > 0,
            badgeColor: Colors.red,
            badgePadding: const EdgeInsets.only(left: 4, right: 4),
          ),
          BottomBarItem(
              icon: const Icon(BootstrapIcons.person_vcard),
              selectedIcon: const Icon(BootstrapIcons.person_vcard_fill),
              selectedColor: const Color(0xFF2F362F),
              unSelectedColor: CupertinoColors.black,
              title:
                  const Text('마이페이지', style: TextStyle(fontFamily: 'KoPub'))),
        ],
        backgroundColor: const Color(0xFFFFF8E7),
        currentIndex: widget.location.contains('/main_page')
            ? 0
            : widget.location.contains('/product_page')
                ? 1
                : widget.location.contains('/shopping_cart_page')
                    ? 2
                    : 3,
        onTap: (int index) {
          if (_status == Status.unavailable) {
            showConnectionErrorDialog();
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            _goOtherTab(context, index);
          }
            _goOtherTab(context, index);

        },
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    // if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    List<String> locations = [
      '/main_page',
      '/product_page',
      '/shopping_cart_page',
      '/profile_page'
    ];
    String? location = locations[index];
    if (index == 3) {
      context.go(FirebaseAuth.instance.currentUser != null
          ? '/profile_page'
          : '/profile_page/login_page');
    } else if (index == 0) {
      router.go(location);
    } else {
      router.go(location, extra: {'navSetState': resetNavigation});
    }
  }
}
