import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page.dart';

import 'main_page.dart';

class Navigation extends StatefulWidget {
  int selectedIndex;

  Navigation({super.key, required this.selectedIndex});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  @override
  Widget build(BuildContext context) {
    final PageController pageViewController =
    PageController(initialPage: widget.selectedIndex);
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        children: const [
          MainPage(),
          // ProductPage(),
          // ShoppingCartPage(),
          // ProfilePage(),
          SignupPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_justify),
            label: '상품',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: '장바구니',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: '마이페이지',
          ),
        ],
        selectedItemColor: const Color(0xFFF88264),
        unselectedItemColor: Colors.grey,
        currentIndex: widget.selectedIndex,
        onTap: (index) {
          setState(() {
            widget.selectedIndex = index;
          });
          pageViewController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
