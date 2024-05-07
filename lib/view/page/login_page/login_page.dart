import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/login_page/login_page_view_model.dart';

import '../../../data/model/order_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var idController = TextEditingController();
  var passwordController = TextEditingController();
  var orderNumberController = TextEditingController();
  var orderedUserController = TextEditingController();

  StreamSubscription? authStateChanges;

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    passwordController.dispose();
    orderedUserController.dispose();
    orderNumberController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      LoginViewModel().initPreferences();
    });
    authStateChanges = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null && mounted) {
        GoRouter.of(context).go('/main_page');
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = LoginViewModel();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64.0),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: idController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '필수항목입니다.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: '아이디'),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '필수항목입니다.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: '비밀번호'),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        viewModel.signIn(idController.text,
                            passwordController.text, context);
                        GoRouter.of(context).go('/main_page');
                      }
                    },
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
                              decoration:
                                  const InputDecoration(hintText: '주문자명'),
                            ),
                            TextField(
                              controller: orderNumberController,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: '주문번호'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final List<OrderModel> orderCheckList =
                                await viewModel.orderCheckforNoMember(
                                    orderNumberController.text,
                                    orderedUserController.text);
                            if (orderCheckList.isNotEmpty && mounted) {
                              GoRouter.of(context).go(
                                  '//shopping_cart_page/fill_order_page/pay_page',
                                  extra: orderCheckList);
                            }
                          },
                          child: const Text('주문확인'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '주문정보를 잊으신 경우 고객센터로 문의바랍니다.',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('아이디 / 비밀번호 찾기'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/login_page/my_detail_page');
                        },
                        child: Text('회원가입'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
