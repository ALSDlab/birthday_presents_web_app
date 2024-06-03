import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/login_page/login_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import '../../../utils/gif_progress_bar.dart';

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
  var orderedUserController = TextEditingController();
  var orderNumberController = TextEditingController();

  StreamSubscription? authStateChanges;
  String? _errorIdText;
  String? _errorPasswordText;
  String? _errorOrdererNameText;
  String? _errorOrderNumberText;

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
    // authStateChanges = FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user != null) {
    //     GoRouter.of(context).go('/main_page');
    //     return;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginPageViewModel>();
    final state = viewModel.state;
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
              child: (state.isLoading)
                  ? Center(
                      child: GifProgressBar(),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                          (MediaQuery.of(context).size.width >= 1200)
                              ? 175
                              : (MediaQuery.of(context).size.width < 900)
                                  ? 25
                                  : (25 +
                                      (MediaQuery.of(context).size.width -
                                              900) /
                                          2),
                          10,
                          (MediaQuery.of(context).size.width >= 1200)
                              ? 175
                              : (MediaQuery.of(context).size.width < 900)
                                  ? 25
                                  : (25 +
                                      (MediaQuery.of(context).size.width -
                                              900) /
                                          2),
                          10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      '로그인',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const Divider(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              TextFormField(
                                                controller: idController,
                                                // validator: (value) {
                                                //   if (value == null || value.isEmpty) {
                                                //     return '필수항목입니다.';
                                                //   }
                                                //   return null;
                                                // },
                                                decoration: InputDecoration(
                                                  hintText: '아이디',
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0.1,
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color:
                                                          (_errorIdText == null)
                                                              ? Colors.grey
                                                              : const Color(
                                                                  0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color:
                                                          (_errorIdText == null)
                                                              ? const Color(
                                                                  0xFF2F362F)
                                                              : const Color(
                                                                  0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _errorIdText =
                                                        (value.isEmpty
                                                            ? '필수항목입니다.'
                                                            : null);
                                                  });
                                                },
                                              ),
                                              if (_errorIdText != null)
                                                Positioned(
                                                  top: 19,
                                                  right: 15,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Text(
                                                      _errorIdText!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFFba1a1a),
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Stack(
                                            children: [
                                              TextFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                // validator: (value) {
                                                //   if (value == null || value.isEmpty) {
                                                //     return '필수항목입니다.';
                                                //   }
                                                //   return null;
                                                // },
                                                decoration: InputDecoration(
                                                  hintText: '비밀번호',
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0.1,
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color:
                                                          (_errorPasswordText ==
                                                                  null)
                                                              ? Colors.grey
                                                              : const Color(
                                                                  0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color:
                                                          (_errorPasswordText ==
                                                                  null)
                                                              ? const Color(
                                                                  0xFF2F362F)
                                                              : const Color(
                                                                  0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _errorPasswordText =
                                                        (value.isEmpty
                                                            ? '필수항목입니다.'
                                                            : null);
                                                  });
                                                },
                                              ),
                                              if (_errorPasswordText != null)
                                                Positioned(
                                                  top: 19,
                                                  right: 15,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Text(
                                                      _errorPasswordText!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFFba1a1a),
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        minimumSize: WidgetStateProperty.all(
                                          Size(double.infinity, 52.h),
                                        ),
                                        shape: const WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                                Color(0xFF008080)),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          _errorIdText =
                                              (idController.text.isEmpty
                                                  ? '필수항목입니다.'
                                                  : null);
                                          _errorPasswordText =
                                              (passwordController.text.isEmpty
                                                  ? '필수항목입니다.'
                                                  : null);
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          await viewModel.signIn(
                                              idController.text,
                                              passwordController.text,
                                              context);
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
                                                  'hideNavBar':
                                                      widget.hideNavBar
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
                                                '/profile_page/login_page/agreement_page',
                                                extra: {
                                                  'hideNavBar':
                                                      widget.hideNavBar
                                                });
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
                                SizedBox(
                                  height: 30.h,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          '비회원 주문 조회',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Stack(
                                        children: [
                                          TextField(
                                            controller: orderedUserController,
                                            decoration: InputDecoration(
                                              hintText: '주문자명',
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  width: 0.1,
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      (_errorOrdererNameText ==
                                                              null)
                                                          ? Colors.grey
                                                          : const Color(
                                                              0xFFba1a1a),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      (_errorOrdererNameText ==
                                                              null)
                                                          ? const Color(
                                                              0xFF2F362F)
                                                          : const Color(
                                                              0xFFba1a1a),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _errorOrdererNameText =
                                                    (value.isEmpty
                                                        ? '필수항목입니다.'
                                                        : null);
                                              });
                                            },
                                          ),
                                          if (_errorOrdererNameText != null)
                                            Positioned(
                                              top: 19,
                                              right: 15,
                                              child: Container(
                                                color: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: Text(
                                                  _errorOrdererNameText!,
                                                  style: const TextStyle(
                                                      color: Color(0xFFba1a1a),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Stack(
                                        children: [
                                          TextField(
                                            controller: orderNumberController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: '주문번호',
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  width: 0.1,
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      (_errorOrderNumberText ==
                                                              null)
                                                          ? Colors.grey
                                                          : const Color(
                                                              0xFFba1a1a),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      (_errorOrderNumberText ==
                                                              null)
                                                          ? const Color(
                                                              0xFF2F362F)
                                                          : const Color(
                                                              0xFFba1a1a),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _errorOrderNumberText =
                                                    (value.isEmpty
                                                        ? '필수항목입니다.'
                                                        : null);
                                              });
                                            },
                                          ),
                                          if (_errorOrderNumberText != null)
                                            Positioned(
                                              top: 19,
                                              right: 15,
                                              child: Container(
                                                color: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: Text(
                                                  _errorOrderNumberText!,
                                                  style: const TextStyle(
                                                      color: Color(0xFFba1a1a),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          '주문정보를 잊으신 경우 고객센터로 문의바랍니다.',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            _errorOrdererNameText =
                                                (orderedUserController
                                                        .text.isEmpty
                                                    ? '필수항목입니다.'
                                                    : null);
                                            _errorOrderNumberText =
                                                (orderNumberController
                                                        .text.isEmpty
                                                    ? '필수항목입니다.'
                                                    : null);
                                          });
                                          final List<OrderModel>
                                              orderCheckList = await viewModel
                                                  .orderCheckforNoMember(
                                                      orderNumberController
                                                          .text,
                                                      orderedUserController
                                                          .text,
                                                      context);
                                          if (orderCheckList.isNotEmpty &&
                                              context.mounted) {
                                            GoRouter.of(context).go(
                                                '/shopping_cart_page/fill_order_page/pay_page',
                                                extra: {
                                                  'orderModelList':
                                                      orderCheckList,
                                                  'hideNavBar':
                                                      widget.hideNavBar
                                                });
                                            widget.hideNavBar(true);
                                          }
                                        },
                                        style: ButtonStyle(
                                          minimumSize: WidgetStateProperty.all(
                                            Size(double.infinity, 52.h),
                                          ),
                                          shape: const WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.black),
                                        ),
                                        child: const Text(
                                          '주문확인',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                const Column(
                                  children: [
                                    Text(
                                      softWrap: true, //긴 텍스트 줄 바꿈
                                      style: TextStyle(
                                          letterSpacing: 1.1,
                                          height: 1.4,
                                          fontFamily: 'Kopub',
                                          color: Colors.grey),
                                      '상호: 건강담은 민영기염소탕 흑염소진액 | 대표: 임유리 | 주소: 충남 아산시 둔포면 중앙공원로 33번길 3-11 | 사업자번호: 106-53-60883 | 통신판매업신고: 2024-충남아산-0466\n| 고객상담실: 041) 531-6023 | e-메일: envy1012@naver.com',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        softWrap: true, //긴 텍스트 줄 바꿈
                                        style: TextStyle(
                                            fontSize: 10,
                                            letterSpacing: 1.1,
                                            height: 1.4,
                                            fontFamily: 'Kopub',
                                            color: Colors.grey),
                                        'ⓒ 2024. 건강담은 민영기염소탕 흑염소진액 Co. All rights reserved.'),
                                  ],
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
