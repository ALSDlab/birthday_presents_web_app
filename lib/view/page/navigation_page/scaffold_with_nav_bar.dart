import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  String location;

  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  static List<TabItem> items = [
    const TabItem(
        icon: FontAwesomeIcons.houseChimney, title: '홈', key: '/main_page'),
    const TabItem(
        icon: FontAwesomeIcons.boxesStacked, title: '상품', key: '/product_page'),
    const TabItem(
        icon: FontAwesomeIcons.cartShopping,
        title: '장바구니',
        key: '/shopping_cart_page'),
    const TabItem(
        icon: FontAwesomeIcons.addressCard,
        title: '마이페이지',
        key: '/profile_page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomBarDivider(
        backgroundColor: Color(0xFFFFF8E7),
        color: CupertinoColors.black,
        colorSelected: Color(0xFF019934),
        styleDivider: StyleDivider.top,
        iconSize: 25,
        titleStyle: const TextStyle(fontFamily: 'KoPub', fontSize: 11),
        indexSelected: widget.location == '/main_page'
            ? 0
            : widget.location == '/product_page'
                ? 1
                : widget.location == '/shopping_cart_page'
                    ? 2
                    : 3,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        items: items,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    // if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String? location = items[index].key;

    setState(() {
      _currentIndex = index;
    });
    if (index == 3) {
      context.go(FirebaseAuth.instance.currentUser != null
          ? '/profile_page'
          : '/profile_page/login_page');
    } else {
      router.go(location!);
    }
  }
}
