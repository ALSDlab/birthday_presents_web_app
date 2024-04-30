import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel {
  Future signIn(String id, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: '$id@gmail.com', password: password);
      context.go('/main_page');
    } catch (e) {
      showDialog(context: context, builder: (context) {
        print(e);
        return AlertDialog(
          title: Text('알림'),
          content: Text('정보가 없습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'),
            )
          ],
        );
      });
    }
  }
}