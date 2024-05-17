import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/change_password_page/change_password_page_view_model.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ChangePasswordViewModel();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F362F),
        title: const Text(
          '마이페이지',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Container(
          color: const Color(0xFFFFF8E7),
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: ListView(
              children: [
                const Text('아이디 찾기'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: '이름'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수항목입니다.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(hintText: '핸드폰 번호'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수항목입니다.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String id = await viewModel.findDocumentId(
                          _nameController.text, _phoneController.text);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: id != ''
                                ? Text('id는 $id 입니다.')
                                : Text(
                                    '입력하신 정보로 아이디를 찾을 수 없습니다. \n다시 시도해주시거나 회원가입을 해주세요.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context.go('/profile_page/login_page');
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('찾기'),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text('비밀번호 변경'),
                Form(
                  key: _formKey2,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: '비밀번호 재설정 안내를 받을 이메일을 입력해주세요.'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '필수항목입니다.';
                      }
                      final RegExp emailRegExp = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegExp.hasMatch(value)) {
                        return '유효한 이메일 주소를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  child: Text('변경하기'),
                  onPressed: () async {
                    if (_formKey2.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _emailController.text);
                      } catch (e) {
                        print(e);
                      }

                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('비밀번호 재설정 메일을 보냈습니다. \n메일을 확인해주세요. '),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.go('/profile_page/login_page');
                                  },
                                  child: const Text('확인'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
