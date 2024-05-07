import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.person),
                Text(FirebaseAuth.instance.currentUser?.displayName ?? '사용자'),
              ],
            ),
            Row(
              children: [
                Text('주문내역'),
                TextButton(
                  onPressed: () {},
                  child: Text('상세보기'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                GoRouter.of(context).go('/main_page');
              },
              child: Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
