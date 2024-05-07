import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class LoginViewModel with ChangeNotifier {
  Future signIn(String id, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: '$id@gmail.com', password: password);
      if (context.mounted) {
        prefs!.setString('_email', '$id@gmail.com');
        context.go('/main_page', extra: 0);
      }
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

  Future<String> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String idMemory = prefs!.getString('_email') ?? '';
    return idMemory;
  }
}