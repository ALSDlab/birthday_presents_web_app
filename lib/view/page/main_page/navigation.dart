import 'package:flutter/material.dart';
import 'package:myk_market_app/data/model/store_model.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:myk_market_app/view/page/product_page/product_page.dart';
import 'package:myk_market_app/view/page/product_page/product_view_model.dart';
import 'package:provider/provider.dart';

import '../register_page/agreement_page.dart';
import 'main_page.dart';

class Navigation extends StatefulWidget {
  int selectedIndex;

  Navigation({super.key, required this.selectedIndex});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    // final PageController pageViewController =
    //     PageController(initialPage: widget.selectedIndex);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ChangeNotifierProvider(
            create: (_) => StoreViewModel(),
            child: const MainPage(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductViewModel(),
            child: const ProductPage(),
          ),
          // ShoppingCartPage(),
          const AgreementPage(),
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
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
          );

          // if (index == 0) {
          //   final viewModel = context.read<StoreViewModel>();
          //   viewModel.loadingHome();
          // }
        },
      ),
    );
  }
}
