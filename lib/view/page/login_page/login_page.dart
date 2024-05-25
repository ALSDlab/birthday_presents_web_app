import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/login_page/login_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.hideNavBar});

  final bool Function(bool) hideNavBar;

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
      final loginViewModel = context.read<LoginPageViewModel>();

      loginViewModel.initPreferences();
    });
    authStateChanges = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        GoRouter.of(context).go('/main_page');
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginPageViewModel>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '마이페이지',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width >= 1200)
              ? 1200
              : MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Container(
              color: const Color(0xFFFFF8E7),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '로그인',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Form(
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
                                      decoration: const InputDecoration(
                                        hintText: '아이디',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
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
                                      decoration: const InputDecoration(
                                        hintText: '비밀번호',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 52.h),
                                  ),
                                  shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color(0xFF008080)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await viewModel.signIn(idController.text,
                                        passwordController.text, context);
                                  }
                                },
                                child: const Text(
                                  '로그인',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.push(
                                          '/profile_page/login_page/change_password_page',
                                          extra: {
                                            'hideNavBar': widget.hideNavBar
                                          });
                                    },
                                    child: const Text(
                                      '아이디 / 비밀번호 찾기',
                                      style: TextStyle(
                                        color: Color(0xFF8e8e93),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.push(
                                          '/profile_page/login_page/agreement_page', extra: {'hideNavBar': widget.hideNavBar});
                                    },
                                    child: const Text(
                                      '회원가입',
                                      style: TextStyle(
                                        color: Color(0xFF8e8e93),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    '비회원 주문 조회',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextField(
                                  controller: orderedUserController,
                                  decoration: const InputDecoration(
                                    hintText: '주문자명',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextField(
                                  controller: orderNumberController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: '주문번호',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    '주문정보를 잊으신 경우 고객센터로 문의바랍니다.',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final List<OrderModel> orderCheckList =
                                        await viewModel.orderCheckforNoMember(
                                            orderNumberController.text,
                                            orderedUserController.text,
                                            context);
                                    if (orderCheckList.isNotEmpty &&
                                        context.mounted) {
                                      GoRouter.of(context).go(
                                          '/shopping_cart_page/fill_order_page/pay_page',
                                          extra: {
                                            'orderModelList': orderCheckList,
                                            'hideNavBar': widget.hideNavBar
                                          });
                                      widget.hideNavBar(true);
                                    }
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 52.h),
                                    ),
                                    shape: const MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.black),
                                  ),
                                  child: const Text(
                                    '주문확인',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
