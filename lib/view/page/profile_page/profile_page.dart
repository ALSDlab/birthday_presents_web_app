import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Container(
          color: const Color(0xFFFFF8E7),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    Text(FirebaseAuth.instance.currentUser?.displayName ??
                        '사용자'),
                  ],
                ),
                Row(
                  children: [
                    const Text('주문내역'),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .push('/profile_page/order_history_page');
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
        ),
      ),
    );
  }
}
