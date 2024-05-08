import 'dart:core';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../shopping_cart_page/shopping_cart_view_model.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  String location;

  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  bool _showCartBadge = false;

  // @override
  // void initState() {
  //   Future.microtask(() async {
  //     final ScaffoldWithNavBarViewModel viewModel =
  //     context.read<ScaffoldWithNavBarViewModel>();
  //     await viewModel.getBadgeCount();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final cartListViewModel = context.watch<ShoppingCartViewModel>();
    final state = cartListViewModel.state;
    _showCartBadge = state.cartList.isNotEmpty;
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          padding: const EdgeInsets.only(top: 8),
          iconSize: 30,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.Default,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(BootstrapIcons.house_door),
            selectedIcon: const Icon(BootstrapIcons.house_door_fill),
            selectedColor: Colors.teal,
            unSelectedColor:  CupertinoColors.black,
            title: const Text(
              '홈',
              style: TextStyle(fontFamily: 'KoPub'),
            ),
          ),
          BottomBarItem(
            icon: const Icon(BootstrapIcons.box2),
            selectedIcon: const Icon(BootstrapIcons.box2_fill),
            selectedColor: const Color(0xFF019934),
            unSelectedColor:  CupertinoColors.black,
            title: const Text(
              '상품',
              style: TextStyle(fontFamily: 'KoPub'),
            ),
          ),
          BottomBarItem(
            icon: const Icon(BootstrapIcons.cart_check),
            selectedIcon: const Icon(BootstrapIcons.cart_check_fill),
            selectedColor: const Color(0xFF019934),
            unSelectedColor:  CupertinoColors.black,
            title: const Text('장바구니', style: TextStyle(fontFamily: 'KoPub')),
            badge: _showCartBadge ? Text('${cartListViewModel.state.cartList.first.count}') : null, // 뱃지 조건을 변경된 상태에 따라 설정
            showBadge: _showCartBadge,
            badgeColor: const Color(0xFF019934),
            badgePadding: const EdgeInsets.only(left: 4, right: 4),
          ),
          BottomBarItem(
              icon: const Icon(BootstrapIcons.person_vcard),
              selectedIcon: const Icon(BootstrapIcons.person_vcard_fill),
              selectedColor: const Color(0xFF019934),
              unSelectedColor:  CupertinoColors.black,
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
    } else {
      router.go(location);
    }
  }
}
