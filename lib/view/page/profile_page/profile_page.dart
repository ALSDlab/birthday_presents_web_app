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
      body: Column(
        children: [
          Text(FirebaseAuth.instance.currentUser?.displayName ?? '사용자'),
          Text('주문내역'),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              GoRouter.of(context).go('/main_page');
            },
            child: Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}
