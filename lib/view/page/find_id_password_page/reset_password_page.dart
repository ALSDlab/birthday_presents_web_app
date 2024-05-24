import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Navigator.pop(context, true); // 전달할 ㄹ새 비밀번호를 true 에 넣으면 됨
    }, child: Text('테스트'));
  }
}
