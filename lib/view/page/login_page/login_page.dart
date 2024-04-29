import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  var orderNumberController = TextEditingController();
  var orderedUserController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    passwordController.dispose();
    orderedUserController.dispose();
    orderNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(128.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '로그인',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      TextField(
                        controller: idController,
                        decoration: const InputDecoration(hintText: '아이디'),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: '비밀번호'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('로그인'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('비회원 주문 조회'),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            TextField(
                              controller: orderedUserController,
                              decoration: const InputDecoration(hintText: '주문자명'),
                            ),
                            TextField(
                              controller: orderNumberController,
                              obscureText: true,
                              decoration: const InputDecoration(hintText: '주문번호'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('주문확인'),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '주문정보를 잊으신 경우 고객센터로 문의바랍니다.',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
