import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../order_history_page/order_history_page_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.person),
                Text(FirebaseAuth.instance.currentUser?.displayName ?? '사용자'),
              ],
            ),
            Row(
              children: [
                const Text('주문내역'),
                TextButton(
                  onPressed: () async {
                    // String currentUser = FirebaseAuth
                    //     .instance.currentUser!.email!
                    //     .replaceAll('@gmail.com', '');
                    // final myOrderItems =
                    //     await viewModel.getMyOrderData(currentUser);
                    // if (context.mounted) {
                    //   GoRouter.of(context).push(
                    //       '/shopping_cart_page/fill_order_page/pay_page',
                    //       extra: {'orderModelList': myOrderItems});
                    // }
                    GoRouter.of(context).push('/profile_page/order_history_page');
                  },
                  child: const Text('상세보기'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                GoRouter.of(context).go('/main_page');
              },
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
